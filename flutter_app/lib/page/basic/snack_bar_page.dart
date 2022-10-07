import 'package:flutter/material.dart';

class SnackBarPage extends StatefulWidget {
  const SnackBarPage({super.key});

  @override
  State<SnackBarPage> createState() => _SnackBarPageState();
}

class _SnackBarPageState extends State<SnackBarPage> {
  // ignore: unused_element
  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.deepOrangeAccent,
        content: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SnackBar'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text('showSnackBar 默认'),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('我是 content'),
                ),
              );
            },
          ),
          ElevatedButton(
            child: const Text('showSnackBar 定制'),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  // 默认值为 SnackBarBehavior.fixed
                  behavior: SnackBarBehavior.floating,
                  // 仅在 behavior 为 SnackBarBehavior.floating 时才能设置 margin
                  margin: const EdgeInsets.all(40),
                  padding: const EdgeInsets.all(30),
                  duration: const Duration(seconds: 10),
                  action: SnackBarAction(
                    label: '关闭',
                    onPressed: () {
                      debugPrint('点击了关闭');
                    },
                  ),
                  backgroundColor: Colors.deepOrangeAccent,
                  content: const Text('我是 content'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
