import 'package:flutter/material.dart';

class InheritedWidgetPage extends StatefulWidget {
  const InheritedWidgetPage({super.key});

  @override
  State<InheritedWidgetPage> createState() => _InheritedWidgetPageState();
}

class _InheritedWidgetPageState extends State<InheritedWidgetPage> {
  int count = 0;

  _increaseCount() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('InheritedWidget'),
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
        ),
        body: CounterProvider(
          count: count,
          increaseCount: _increaseCount,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('外部：$count'),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _increaseCount,
                      child: const Text('外部：count++'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const UseCounterStatefulWidget(),
                const SizedBox(height: 20),
                const UseCounterStatelessWidget(),
                const SizedBox(height: 20),
                const NotUseCounterStatefulWidget(),
              ],
            ),
          ),
        ));
  }
}

class UseCounterStatefulWidget extends StatefulWidget {
  const UseCounterStatefulWidget({super.key});

  @override
  State<UseCounterStatefulWidget> createState() =>
      _UseCounterStatefulWidgetState();
}

class _UseCounterStatefulWidgetState extends State<UseCounterStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    CounterProvider? counterProvider = CounterProvider.of(context);
    return Row(
      children: [
        const Text('UseCounterStatefulWidget'),
        const SizedBox(width: 20),
        Text('内部：${counterProvider?.count}'),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: counterProvider?.increaseCount,
          child: const Text('内部：count++'),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 父或祖先 widget 中的 InheritedWidget 改变 updateShouldNotify 返回 true 时会被调用
    // 如果 build 中没有依赖 InheritedWidget，则此回调不会被调用
    debugPrint("UseCounterStatefulWidget didChangeDependencies");
  }
}

class UseCounterStatelessWidget extends StatelessWidget {
  const UseCounterStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    CounterProvider? counterProvider = CounterProvider.of(context);
    return Row(
      children: [
        const Text('UseCounterStatelessWidget'),
        const SizedBox(width: 20),
        Text('内部：${counterProvider?.count}'),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: counterProvider?.increaseCount,
          child: const Text('内部：count++'),
        ),
      ],
    );
  }
}

class NotUseCounterStatefulWidget extends StatefulWidget {
  const NotUseCounterStatefulWidget({super.key});

  @override
  State<NotUseCounterStatefulWidget> createState() =>
      _NotUseCounterStatefulWidgetState();
}

class _NotUseCounterStatefulWidgetState
    extends State<NotUseCounterStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text('NotUseCounterStatefulWidget'),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 父或祖先 widget 中的 InheritedWidget 改变 updateShouldNotify 返回 true 时会被调用
    // 如果 build 中没有依赖 InheritedWidget，则此回调不会被调用
    debugPrint("NotUseCounterStatefulWidget didChangeDependencies");
  }
}

class CounterProvider extends InheritedWidget {
  final int count; // 需要在子树中共享的数据，保存点击次数
  final VoidCallback increaseCount;

  const CounterProvider({
    super.key,
    required super.child,
    required this.count,
    required this.increaseCount,
  });

  // 定义一个便捷方法，方便子树中的 widget 获取共享数据
  static CounterProvider? of(BuildContext context) {
    // 类似于 React 中的 useContext
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  // 该回调决定当 counter 发生变化时，是否通知子树中依赖 counter 的 Widget 重新 build
  @override
  bool updateShouldNotify(CounterProvider oldWidget) {
    return oldWidget.count != count;
  }
}
