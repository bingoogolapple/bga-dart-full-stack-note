import 'dart:async';
import 'package:flutter/material.dart';

class BlocPage extends StatefulWidget {
  const BlocPage({super.key});

  @override
  State<BlocPage> createState() => _BlocPageState();
}

class _BlocPageState extends State<BlocPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bloc'),
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
        ),
        body: CounterProvider(
          counterBloc: CounterBloc(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                // Builder(
                //   builder: (context) {
                //     return StreamBuilder(
                //       stream:
                //           CounterProvider.of(context)?.counterBloc.countStream,
                //       initialData: 0,
                //       builder:
                //           (BuildContext context, AsyncSnapshot<int> snapshot) {
                //         return Row(
                //           children: [
                //             Text('外部：${snapshot.data}'),
                //             const SizedBox(width: 20),
                //             ElevatedButton(
                //               onPressed: () => CounterProvider.of(context)
                //                   ?.counterBloc
                //                   .countSink
                //                   .add(1),
                //               child: const Text('外部：加 1'),
                //             ),
                //           ],
                //         );
                //       },
                //     );
                //   },
                // ),
                const SizedBox(height: 20),
                const UseCounterStatefulWidget(),
                const SizedBox(height: 20),
                // const UseCounterStatelessWidget(),
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
    return StreamBuilder(
      stream: counterProvider?.counterBloc.countStream,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return Row(
          children: [
            const Text('UseCounterStatefulWidget'),
            const SizedBox(width: 20),
            Text('内部：${snapshot.data}'),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () => counterProvider?.counterBloc.countSink.add(3),
              child: const Text('内部：加 3'),
            ),
          ],
        );
      },
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
    return StreamBuilder(
      stream: counterProvider?.counterBloc.countStream,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return Row(
          children: [
            const Text('UseCounterStatelessWidget'),
            const SizedBox(width: 20),
            Text('内部：${snapshot.data}'),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () => counterProvider?.counterBloc.countSink.add(3),
              child: const Text('内部：加 3'),
            ),
          ],
        );
      },
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
  final CounterBloc counterBloc; // 需要在子树中共享的数据，保存点击次数

  const CounterProvider({
    super.key,
    required super.child,
    required this.counterBloc,
  });

  // 定义一个便捷方法，方便子树中的 widget 获取共享数据
  static CounterProvider? of(BuildContext context) {
    // 类似于 React 中的 useContext
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  // 该回调决定当 counter 发生变化时，是否通知子树中依赖 counter 的 Widget 重新 build
  @override
  bool updateShouldNotify(CounterProvider oldWidget) {
    return oldWidget.counterBloc != counterBloc;
  }
}

class CounterBloc {
  int _count = 0;

  final _counterActionController = StreamController<int>();
  // 用于输入数据
  StreamSink get countSink => _counterActionController.sink;

  final _counterStreamController = StreamController<int>();
  // 用于输出数据，countStream 只能被使用一次
  Stream<int> get countStream => _counterStreamController.stream;

  CounterBloc() {
    _counterActionController.stream.listen((data) {
      _count += data;
      _counterStreamController.add(_count);
    });
  }

  disponse() {
    _counterActionController.close();
    _counterStreamController.close();
  }
}
