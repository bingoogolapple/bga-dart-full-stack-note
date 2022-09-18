import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

// showGeneralDialog 返回 Object，showDialog 返回 dynamic

class _DialogPageState extends State<DialogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialog'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text('showDialog ElevatedButton'),
            onPressed: () async {
              final String? result = await showDialog(
                // 点击遮罩时不关闭对话框，默认可以关闭
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return Column(
                    children: [
                      const Text('我是body'),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, '我是返回值');
                        },
                        child: const Text('返回数据'),
                      )
                    ],
                  );
                },
              );
              debugPrint('返回结果为: $result');
            },
          ),
          ElevatedButton(
            child: const Text('showDialog Scaffold'),
            onPressed: () async {
              final String? result = await showDialog(
                context: context,
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('我是标题'),
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                        // tooltip: '关闭',
                      ),
                    ),
                    body: Column(
                      children: [
                        const Text('我是body'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, '我是返回值');
                          },
                          child: const Text('返回数据'),
                        )
                      ],
                    ),
                  );
                },
              );
              debugPrint('返回结果为: $result');
            },
          ),
          ElevatedButton(
            child: const Text('showDialog Dialog'),
            onPressed: () async {
              final String? result = await showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Column(
                      children: [
                        const Text('我是body'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, '我是返回值');
                          },
                          child: const Text('返回数据'),
                        )
                      ],
                    ),
                  );
                },
              );
              debugPrint('返回结果为: $result');
            },
          ),
          ElevatedButton(
            child: const Text('showDialog SimpleDialog'),
            onPressed: () async {
              final String? result = await showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: const Text('SimpleDialog'),
                    children: <Widget>[
                      SimpleDialogOption(
                        child: const Text('选项 A'),
                        onPressed: () {
                          Navigator.pop(context, 'A');
                        },
                      ),
                      SimpleDialogOption(
                        child: const Text('选项 B'),
                        onPressed: () {
                          Navigator.pop(context, 'B');
                        },
                      ),
                      SimpleDialogOption(
                        child: const Text('选项 C'),
                        onPressed: () {
                          Navigator.pop(context, 'C');
                        },
                      ),
                    ],
                  );
                },
              );
              debugPrint('返回结果为: $result');
            },
          ),
          ElevatedButton(
            child: const Text('showDialog AlertDialog'),
            onPressed: () async {
              final String? result = await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('title'),
                    content: const Text('content'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('取消'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('确定'),
                      ),
                    ],
                  );
                },
              );
              debugPrint('返回结果为: $result');
            },
          ),
          ElevatedButton(
            child: const Text('showGeneralDialog ElevatedButton'),
            onPressed: () async {
              final String? result = await showGeneralDialog(
                context: context,
                pageBuilder: (context, animation, secondaryAnimation) {
                  return Column(
                    children: [
                      const Text('我是body'),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, '我是返回值');
                        },
                        child: const Text('返回数据'),
                      )
                    ],
                  );
                },
              );
              debugPrint('返回结果为: $result');
            },
          ),
          ElevatedButton(
            child: const Text('showAboutDialog'),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'applicationName',
                applicationLegalese: 'applicationLegalese',
                applicationIcon: const Icon(Icons.home),
                applicationVersion: '版本 1.0.0',
                children: [
                  const Text('子组件1'),
                  const Text('子组件2'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
