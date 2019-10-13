import 'package:flutter/material.dart';

class AnimApp extends StatefulWidget {
  @override
  _AnimAppState createState() => _AnimAppState();
}

/// 1、Animation 是 Flutter 动画库中的核心类，会根据预定规则，在单位时间内持续输出动画的当前状态。Animation 知道当前动画的状态（比如，动画是否开始、停止、前进或者后退，以及动画的当前值），但却不知道这些状态究竟应用在哪个组件对象上。换句话说，Animation 仅仅是用来提供动画数据，而不负责动画的渲染。
/// 2、AnimationController 用于管理 Animation，可以用来设置动画的时长、启动动画、暂停动画、反转动画等。
/// 3、Listener 是 Animation 的回调函数，用来监听动画的进度变化，我们需要在这个回调函数中，根据动画的当前值重新渲染组件，实现动画的渲染。
/// 4、在创建 AnimationController 的时候设置的 vsync 属性是用来防止出现不可见动画的，vsync 对象会把动画绑定到一个 Widget，当 Widget 不显示时，动画将会暂停（只是不会掉 listener，Animation 中的状态还是在变化），当 Widget 再次显示时，动画会重新恢复执行，这样就可以避免动画的组件不在当前屏幕时白白消耗资源。
/// 5、在页面销毁时，要释放动画资源 AnimationController.dispose()
class _AnimAppState extends State<AnimApp> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    // 创建动画周期为 2 秒的 AnimationController 对象
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))
      ..addListener(() {
        // 监听刷新界面
        setState(() {
          print('_controller.value：${_controller.value}'); // 默认从 0 到 1，可以通过构造方法中的 lowerBound 和 upperBound 来修改
          print('_controller.view.value：${_controller.view.value}'); // 默认从 0 到 1，_controller.view 就是 _controller 自己
        });
      })
      ..addStatusListener((AnimationStatus status) {
        // dismissed：正向动画的初始状态
        // forward：正在从开始到结尾的状态（即使触发了暂停）
        // reverse：正在从结束到开始的状态（即使触发了暂停）
        // completed：正向动画的结束状态
        print('_controller status：$status');
      });

    _initCurvedAnimation();
  }

  void _initDefaultAnimation() {
    // _controller 默认的 Animation 是从 0 到 1 的线性变化
    _animation = _controller.view;
  }

  void _initTweenAnimation() {
    // 创建从 50 到 200 线性变化的 Animation 对象
    _animation = Tween(begin: 50.0, end: 200.0).animate(_controller)
      ..addListener(() {
        // 监听刷新界面
        setState(() {
          print('_animation.value：${_animation.value}');
        });
      })
      ..addStatusListener((AnimationStatus status) {
        print('_animation：$status');
      });
  }

  void _initCurvedAnimation() {
    // 创建一条震荡曲线
    final CurvedAnimation curve = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    // 创建从 50 到 200 跟随振荡曲线变化的 Animation 对象
    _animation = Tween(begin: 50.0, end: 200.0).animate(curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimDemoOne'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: <Widget>[
          Wrap(
            children: [
              // 从当前状态开始正向动画（如果已经是完成状态则不会动）
              MaterialButton(child: Text('forward()'), onPressed: () => _controller.forward()),
              // 从当前状态开始反向动画（如果已经是初始状态则不会动）
              MaterialButton(child: Text('reverse()'), onPressed: () => _controller.reverse()),
              // 重置到初始状态
              MaterialButton(child: Text('reset()'), onPressed: () => _controller.reset()),
              // 停止动画
              MaterialButton(child: Text('stop()'), onPressed: () => _controller.stop()),
              // 重复开始执行到结束，然后立即调到开始再执行到结束
              MaterialButton(child: Text('repeat()'), onPressed: () => _controller.repeat()),
              MaterialButton(
                  child: Text('repeat(reverse: true)'),
                  onPressed: () {
                    // 重复的开始->结束->开始->结束，如果正在执行反向动画时这样调用该方法的话会立即变为正向。这里指定的 period 会覆盖创建 _controller 时指定的时间
                    _controller.repeat(reverse: true, min: 0.2, max: 0.8, period: Duration(seconds: 5));
                  }),
              // 获取动画状态
              MaterialButton(child: Text('getStatus'), onPressed: () => print('status：${_animation.status}')),
              // 是否正在执行正向或反向动画
              MaterialButton(child: Text('isAnimating'), onPressed: () => print('isAnimating：${_controller.isAnimating}')),
              // 开始正向动画
              MaterialButton(child: Text('velocity2'), onPressed: () => _controller.fling(velocity: 0.01)),
              // 开始反向动画
              MaterialButton(child: Text('velocity-2'), onPressed: () => _controller.fling(velocity: -0.01)),
            ],
          ),
          Expanded(
            child: Center(
              child: Container(
                width: _animation.value,
                height: _animation.value,
                child: FlutterLogo(),
              ),
            ),
          ),
          Expanded(child: _AnimatedLogo(animation: _controller)),
          Expanded(
            child: Center(
              child: AnimatedBuilder(
                // 通过 AnimatedBuilder 将动画和渲染职责分离。其实 AnimatedBuilder 是继承自 AnimatedWidget，增加了 TransitionBuilder 回调接口
                  animation: _controller,
                  child: FlutterLogo(), // 只会执行一次，动画变化时不会执行
                  builder: (context, child) {
                    // 动画变化时会执行
                    double size = Tween(begin: 50.0, end: 200.0).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceIn)).value;
                    return Container(child: child, width: size, height: size);
                  }),
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Hero(
                tag: 'hero', // 设置共享 tag
                child: Container(width: 100, height: 100, child: FlutterLogo()),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => HeroPageTwo())); // 点击后打开第二个页面
              },
            ),
          )
        ],
      ),
    );
  }
}

/// 由于动画过程涉及到页面的频繁刷新，因此尽量使用 AnimatedWidget 或 AnimatedBuilder 来缩小受动画影响的组件范围，只重绘需要做动画的组件即可
/// 要避免使用进度监听器直接刷新整个页面，导致不需要做动画的组件也跟着一起销毁重建。
class _AnimatedLogo extends AnimatedWidget {
  // AnimatedWidget 需要在初始化时传入 animation 对象
  _AnimatedLogo({Key key, Animation<double> animation}) : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    // 取出动画对象
    Animation<double> animation = CurvedAnimation(parent: listenable, curve: const Interval(0.5, 0.8));
    double size = animation.value * 50 + 50;
    return Container(
      height: size, // 根据动画对象的当前状态更新宽高
      width: size,
      child: FlutterLogo(),
    );
  }
}

class HeroPageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('HeroPageTwo')),
        body: Center(
          child: GestureDetector(
            child: Hero(
              tag: 'hero', // 设置共享 tag
              child: Container(width: 300, height: 300, child: FlutterLogo()),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ));
  }
}
