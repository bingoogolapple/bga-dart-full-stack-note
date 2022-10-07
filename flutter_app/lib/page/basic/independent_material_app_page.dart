import 'package:flutter/material.dart';

class IndependentMaterialAppPage extends StatelessWidget {
  const IndependentMaterialAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取路由参数
    var args = ModalRoute.of(context)?.settings.arguments;
    debugPrint('IndependentMaterialAppPage build 参数为: $args');

    // 如果子页面想做为独立模块，不想展示返回按钮，也可以把 MaterialApp 作为子页面的根组件
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'IndependentMaterialAppPage',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('IndependentMaterialAppPage'),
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
      ),
    );
  }
}
