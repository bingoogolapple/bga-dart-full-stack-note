import 'package:flutter/material.dart';

class RouteParamsPage extends StatelessWidget {
  const RouteParamsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取路由参数
    var args = ModalRoute.of(context)?.settings.arguments;
    debugPrint('RouteParamsPage build 参数为: $args');

    // 需要用 Scaffold 包裹才会有顶部菜单的返回按钮
    return Scaffold(
      appBar: AppBar(
        title: const Text('RouteParams'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, '我是结果'),
              child: const Text('返回结果'),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('不返回结果'),
            )
          ],
        ),
      ),
    );
  }
}
