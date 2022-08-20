import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:math' as math;

class GesturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('处理手势'),
      ),
      body: ListView(
        children: [
          EventDispatchWidget(),
          GestureDetectorWidget(),
          MouseRegionWidget(),
          PointerEventWidget(),
          InkWellButton(),
          DismissibleList(),
        ],
      ),
    );
  }
}

class EventDispatchWidget extends StatefulWidget {
  @override
  _EventDispatchWidgetState createState() => _EventDispatchWidgetState();
}

class _EventDispatchWidgetState extends State<EventDispatchWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTapDown: (TapDownDetails details) => print('父容器1 onTapDown'),
          onTapUp: (TapUpDetails details) => print('子容器1 onTapUp'),
          onTap: () => print('父容器1 onTap'),
          // 如果子容器有监听 onTap，那父容器就不能收到 onTap
          onTapCancel: () => print('父容器1 onTapCancel'),
          onDoubleTap: () => print('父容器1 onDoubleTap'),
          // 如果子容器没有监听 onDoubleTap，那父容器能收到 onDoubleTap
          //
          onLongPressStart: (LongPressStartDetails details) => print('父容器1 onLongPressStart'),
          onLongPress: () => print('父容器1 onLongPress'),
          onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) => print('父容器1 onLongPressMoveUpdate'),
          onLongPressEnd: (LongPressEndDetails details) => print('父容器1 onLongPressEnd'),
          onLongPressUp: () => print('父容器1 onLongPressUp'),
          //
          child: Container(
            color: Colors.blue[100],
            height: 300,
            child: Center(
              child: GestureDetector(
                onTapDown: (TapDownDetails details) => print('子容器1 onTapDown'),
                onTapUp: (TapUpDetails details) => print('子容器1 onTapUp'),
                onTap: () => print('子容器1 onTap'),
                onTapCancel: () => print('子容器1 onTapCancel'),
                //
                onLongPressStart: (LongPressStartDetails details) => print('子容器1 onLongPressStart'),
                onLongPress: () => print('子容器1 onLongPress'),
                onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) => print('子容器1 onLongPressMoveUpdate'),
                onLongPressEnd: (LongPressEndDetails details) => print('子容器1 onLongPressEnd'),
                onLongPressUp: () => print('子容器1 onLongPressUp'),
                //
                child: Container(
                  color: Colors.blue[200],
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ),
        ),
        RawGestureDetector(
          // 自己构造父 Widget 的手势识别映射关系
          gestures: {
            MultipleTapGestureRecognizer: GestureRecognizerFactoryWithHandlers<MultipleTapGestureRecognizer>(
              () => MultipleTapGestureRecognizer(),
              (TapGestureRecognizer instance) {
                print('建立多手势识别器与手势识别工厂类的映射关系，从而返回可以响应该手势的 recognizer');
                instance.onTapDown = (TapDownDetails details) => print('父容器2 onTapDown');
                instance.onTapUp = (TapUpDetails details) => print('父容器2 onTapUp');
                instance.onTap = () => print('父容器2 onTap');
                instance.onTapCancel = () => print('父容器2 onTapCancel');
              },
            ),
            MultipleLongPressGestureRecognizer: GestureRecognizerFactoryWithHandlers<MultipleLongPressGestureRecognizer>(
              () => MultipleLongPressGestureRecognizer(),
              (LongPressGestureRecognizer instance) {
                instance.onLongPressStart = (LongPressStartDetails details) => print('父容器2 onLongPressStart');
                instance.onLongPress = () => print('父容器2 onLongPress');
                instance.onLongPressMoveUpdate = (LongPressMoveUpdateDetails details) => print('父容器2 onLongPressMoveUpdate');
                instance.onLongPressEnd = (LongPressEndDetails details) => print('父容器2 onLongPressEnd');
                instance.onLongPressUp = () => print('父容器2 onLongPressUp');
                // ignore: todo
                // TODO 为什么长按是没有触发父容器的 onTapCancel，触发了 onTapUp 和 onTap？
              },
            )
          },
          child: Container(
            color: Colors.red[100],
            height: 300,
            child: Center(
              child: GestureDetector(
                onTapDown: (TapDownDetails details) => print('子容器2 onTapDown'),
                onTapUp: (TapUpDetails details) => print('子容器2 onTapUp'),
                onTap: () => print('子容器2 onTap'),
                onTapCancel: () => print('子容器2 onTapCancel'),
                //
                onLongPressStart: (LongPressStartDetails details) => print('子容器2 onLongPressStart'),
                onLongPress: () => print('子容器2 onLongPress'),
                onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) => print('子容器2 onLongPressMoveUpdate'),
                onLongPressEnd: (LongPressEndDetails details) => print('子容器2 onLongPressEnd'),
                onLongPressUp: () => print('子容器2 onLongPressUp'),
                //
                child: Container(
                  color: Colors.red[200],
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

/// GestureDetector 内部对每一个手势都建立了一个工厂类（Gesture Factory）。而工厂类的内部会使用手势识别类（GestureRecognizer），来确定当前处理的手势
class MultipleTapGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    print('让这个识别器在竞技场被 PK 失败时，能够再把自己重新添加回来，以便接下来还能继续去响应用户事件。每次 Down 时都会触发该方法，都必须重新添加回来，不然收不到此次 Down 及之后的事件');
    acceptGesture(pointer);
  }
}

class MultipleLongPressGestureRecognizer extends LongPressGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}

class MouseRegionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.deepPurpleAccent[100],
      child: Padding(
        padding: EdgeInsets.all(20),
        child: MouseRegion(
          child: Container(width: 100, height: 100, color: Colors.red, child: Text('MouseRegionWidget')),
          onEnter: (PointerEnterEvent event) {
            print('onPointerEnter：$event');
          },
          onExit: (PointerExitEvent event) {
            print('onPointerExit：$event');
          },
          onHover: (PointerHoverEvent event) {
            print('onPointerHover：$event');
          },
        ),
      ),
    );
  }
}

// 指针事件
class PointerEventWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// event.position：Offset 相对于屏幕左上角的坐标
    /// event.localPosition：Offset 相对于控件左上角的坐标
    return Container(
      height: 200,
      color: Colors.deepPurpleAccent[200],
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Listener(
          child: ListView(children: [
            Container(color: Colors.red, height: 100, child: Text('PointerEventWidget')),
            Container(color: Colors.green, height: 100, child: Text('PointerEventWidget')),
            Container(color: Colors.blue, height: 100, child: Text('PointerEventWidget')),
          ]),
          onPointerDown: (PointerDownEvent event) {
            // 鼠标按下、手指按下
            print('onPointerDown：$event');
          },
          onPointerMove: (PointerMoveEvent event) {
            // 鼠标按下移动、手指触摸滚动
            print('onPointerMove：$event');
            // event.delta：Offset 水平或垂直方向移动的距离
            print('onPointerMove delta：${event.delta}');
          },
          onPointerUp: (PointerUpEvent event) {
            // 鼠标松开、手指松开
            print('onPointerUp：$event');
          },
          onPointerCancel: (PointerCancelEvent event) {
            // 不是由用户触发的，而是系统经过逻辑判断后对某个 Widget 发送取消事件
            print('onPointerCancel：$event');
          },
          onPointerSignal: (PointerSignalEvent event) {
            // 鼠标滚动
            print('onPointerSignal：$event');
          },
          // onPointerEnter: (PointerEnterEvent event) {
          //   // 鼠标从浏览器内部的非按钮区域->移入按钮区域 | 鼠标第一次从浏览器外->移入按钮区域
          //   print('onPointerEnter：$event');
          // },
          // onPointerExit: (PointerExitEvent event) {
          //   // 鼠标从按钮区域->移到浏览器内部的非按钮区域（直接从按钮区域移到浏览器外部时不会触发该事件）
          //   print('PointerExitEvent：$event');
          // },
          onPointerHover: (PointerHoverEvent event) {
            // 鼠标在按钮区域移动
            print('PointerHoverEvent：$event');
            print('PointerHoverEvent delta：${event.delta}');
          },
        ),
      ),
    );
  }
}

class GestureDetectorWidget extends StatefulWidget {
  @override
  _GestureDetectorWidgetState createState() => _GestureDetectorWidgetState();
}

class _GestureDetectorWidgetState extends State<GestureDetectorWidget> {
  double _top = 20;
  double _left = 20;
  double _originTop = 20;
  double _originLeft = 20;
  bool _longPressed = false;
  bool _pan = false;
  double _width = 200;
  double _height = 50;
  double _scale = 1.0;
  double _rotation = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.deepPurpleAccent[400],
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Positioned(
              top: _top,
              left: _left,
              child:
//              RotatedBox(
//                quarterTurns: 1, // 1、2、3、4 分别选中 90、180、270、360 度，RotatedBox 的变换是在 layout 阶段，会影响在子 Widget 的位置和大小
                  Transform.rotate(
                // Transform 的变换是应用在绘制阶段，所以无论对子 Widget 应用何种变化，其占用空间的大小和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的。
                angle: math.pi * _rotation, // 按 π 来算的，3.1415926 旋转 180 度，常量 math.sqrt1_2
                child: GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Container(
                          width: _width,
                          height: _height,
                          color: _pan ? Colors.blue : _longPressed ? Colors.yellow : Colors.red,
                          child: Transform.scale(scale: _scale, child: Text('上面 GestureDetectorWidget'))),
                      Container(
                          width: _width,
                          height: _height,
                          color: _pan ? Colors.blue : _longPressed ? Colors.yellow : Colors.green,
                          child: Transform.scale(scale: _scale, child: Text('下面 GestureDetectorWidget'))),
                    ],
                  ),
                  onTapDown: (TapDownDetails details) {
                    /// details.position：Offset 相对于屏幕左上角的坐标
                    /// details.localPosition：Offset 相对于控件左上角的坐标
                    print('onTapDown globalPosition：${details.globalPosition} localPosition：${details.localPosition} kind：${details.kind}');
                    // onPanDown -> onPanCancel -> onTapDown -> onTapUp -> onTap
                    // onPanDown -> onTapDown -> onTapCancel -> onPanCancel -> onLongPressStart -> onLongPress -> onLongPressEnd -> onLongPressUp
                    // onPanDown -> onTapDown -> onTapCancel -> onPanCancel -> onLongPressStart -> onLongPress -> onLongPressMoveUpdate（多次） -> onLongPressEnd -> onLongPressUp
                  },
                  onTapUp: (TapUpDetails details) {
                    print('onTapUp：$details');
                  },
                  onTap: () {
                    print('onTap');
                  },
                  onTapCancel: () {
                    print('onTapCancel');
                  },
                  onDoubleTap: () {
                    // onPanDown -> onPanCancel -> onPanDown -> onPanCancel -> onDoubleTap
                    print('onDoubleTap');
                  },
                  onSecondaryTapDown: (TapDownDetails details) {
                    print('onSecondaryTapDown');
                  },
                  onSecondaryTapUp: (TapUpDetails details) {
                    print('onSecondaryTapUp：$details');
                  },
                  onSecondaryTapCancel: () {
                    print('onSecondaryTapCancel');
                  },
                  onLongPressStart: (LongPressStartDetails details) {
                    print('onLongPressStart $details');
                    _originLeft = _left;
                    _originTop = _top;
                    setState(() {
                      _longPressed = true;
                    });
                  },
                  onLongPress: () {
                    print('onLongPress');
                  },
                  onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) {
                    print('onLongPressMoveUpdate localPosition ${details.localPosition.dx}');
                    print('onLongPressMoveUpdate localOffsetFromOrigin ${details.localOffsetFromOrigin.dx}');
                    setState(() {
                      _left = _originLeft + details.localOffsetFromOrigin.dx;
                      _top = _originTop + details.localOffsetFromOrigin.dy;
                    });
                  },
                  onLongPressEnd: (LongPressEndDetails details) {
                    print('onLongPressEnd $details');
                    setState(() {
                      // ignore: todo
                      // TODO 按菜单或 home 键后不会触发 onLongPressEnd、onLongPressUp，如何恢复状态？
                      _longPressed = false;
                    });
                  },
                  onLongPressUp: () {
                    print('onLongPressUp');
                  },
                  ////////////////////////////////////////////////////////////////////////////////////////////////////
//                onPanDown: (DragDownDetails details) {
//                  // onPanDown -> （onTapDown -> onTapCancel）「可选，一开始就快速移动的话就没有」 -> onPanStart -> onPanUpdate（多次）-> onPanEnd
//                  // onPanDown -> onTapDown -> onTapCancel -> onPanCancel
//                  print('onPanDown $details');
//                },
//                /// 同时指定了 onHorizontalDragXxx 和 onVerticalDragXxx 时不能指定 onPanStart、onPanUpdate、onPanEnd，否则会报错
//                /// 指定了 onHorizontalDragXxx 或 onVerticalDragXxx 时 onPanStart、onPanUpdate、onPanEnd 不会被触发
//                /// onPanUpdate 能同时往多个方向拖拽，同时指定了 onHorizontalDragXxx 和 onVerticalDragXxx 时同一次拖拽只能往某一个方向拖拽
//                onPanStart: (DragStartDetails details) {
//                  print('onPanStart $details');
//                  setState(() {
//                    _pan = true;
//                  });
//                },
//                onPanUpdate: (DragUpdateDetails details) {
//                  // delta 相对于上一次移动的距离。onPanUpdate 时 primaryDelta 为 null，onHorizontalDragUpdate、onVerticalDragUpdate 时 primaryDelta 为对应方向相对于上一次移动的距离
//                  print('onPanUpdate delta：${details.delta} | ${details.primaryDelta}');
//                  setState(() {
//                    _left += details.delta.dx;
//                    _top += details.delta.dy;
//                  });
//                },
//                onPanEnd: (DragEndDetails details) {
//                  print('onPanEnd $details | ${details.velocity} | ${details.primaryVelocity}');
//                  setState(() {
//                    _pan = false;
//                  });
//                },
//                onPanCancel: () {
//                  print('onPanCancel');
//                },
                  ////////////////////////////////////////////////////////////////////////////////////////////////////
//                onHorizontalDragDown: (DragDownDetails details) {
//                  print('onHorizontalDragDown $details');
//                },
//                onHorizontalDragStart: (DragStartDetails details) {
//                  print('onHorizontalDragStart $details');
//                },
//                onHorizontalDragUpdate: (DragUpdateDetails details) {
//                  print('onHorizontalDragUpdate $details | ${details.delta} | ${details.primaryDelta}');
//                  setState(() {
//                    _left += details.primaryDelta;
//                  });
//                },
//                onHorizontalDragEnd: (DragEndDetails details) {
//                  print('onHorizontalDragEnd $details | ${details.velocity} | ${details.primaryVelocity}');
//                },
//                onHorizontalDragCancel: () {
//                  print('onHorizontalDragCancel');
//                },
//                onVerticalDragDown: (DragDownDetails details) {
//                  print('onVerticalDragDown $details');
//                },
//                onVerticalDragStart: (DragStartDetails details) {
//                  print('onVerticalDragStart $details');
//                },
//                onVerticalDragUpdate: (DragUpdateDetails details) {
//                  print('onVerticalDragUpdate $details | ${details.delta} | ${details.primaryDelta}');
//                  setState(() {
//                    _top += details.primaryDelta;
//                  });
//                },
//                onVerticalDragEnd: (DragEndDetails details) {
//                  print('onVerticalDragEnd $details | ${details.velocity} | ${details.primaryVelocity}');
//                },
//                onVerticalDragCancel: () {
//                  print('onVerticalDragCancel');
//                },
                  ////////////////////////////////////////////////////////////////////////////////////////////////////
                  onForcePressStart: (ForcePressDetails details) {
                    print('onForcePressStart $details');
                  },
                  onForcePressUpdate: (ForcePressDetails details) {
                    print('onForcePressUpdate $details');
                  },
                  onForcePressEnd: (ForcePressDetails details) {
                    print('onForcePressEnd $details');
                  },
                  onForcePressPeak: (ForcePressDetails details) {
                    print('onForcePressPeak $details');
                  },
                  ////////////////////////////////////////////////////////////////////////////////////////////////////
                  // 指定了 onHorizontalDragXxx 或 onVerticalDragXxx 或 onPanXxx 时再指定 onScaleXxx 会报错，所以想使用 onScaleXxx 时只能通过 onLongPressXxx 来更新位置
                  onScaleStart: (ScaleStartDetails details) {
                    // details.focalPoint 性对于屏幕左上角的中心点，details.localFocalPoint 相对于控件左上角的中心点
                    print('onScaleStart $details');
                  },
                  onScaleUpdate: (ScaleUpdateDetails details) {
                    print('onScaleUpdate $details');
                    if (details.horizontalScale == 1.0 && details.verticalScale == 1.0) {
                      // 当个手指触摸移动时也会触发 onScaleXxx，此时两个方向的 scale 都是 1.0，需要忽略
                      return;
                    }
                    setState(() {
                      double originCenterX = _width / 2 + _left;
                      double originCenterY = _height + _top; // 这里是两个 Widget 重叠的，高度不除以 2

                      _width = 200 * details.horizontalScale + 20;
                      _height = 50 * details.verticalScale + 20;

                      _left = originCenterX - _width / 2;
                      _top = originCenterY - _height; // 这里是两个 Widget 重叠的，高度不除以 2

                      _scale = details.scale;
                      _rotation = details.rotation;
                    });
                  },
                  onScaleEnd: (ScaleEndDetails details) {
                    print('onScaleEnd $details');
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InkWellButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('点击了 InkWellButton');
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Text('InkWellButton'),
      ),
    );
  }
}

class DismissibleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> items = List<String>.generate(20, (i) => "滑动删除 ${i + 1}");
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
          key: Key(item),
          onDismissed: (direction) {
            items.removeAt(index);
          },
          background: Container(color: Colors.red),
          child: ListTile(title: Text('$item')),
        );
      },
    );
  }
}
