import 'package:flutter/material.dart';

class BottomSheetPage extends StatefulWidget {
  const BottomSheetPage({super.key});

  @override
  State<BottomSheetPage> createState() => _BottomSheetPageState();
}

class _BottomSheetPageState extends State<BottomSheetPage> {
  final _bottomSheetScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _bottomSheetScaffoldKey,
      appBar: AppBar(
        title: const Text('BottomSheet'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text('showBottomSheet'),
            onPressed: () {
              _bottomSheetScaffoldKey.currentState?.showBottomSheet(
                (context) {
                  return SizedBox(
                    height: 200.0,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: const Text('选项 A'),
                          onTap: () {
                            Navigator.pop(context, 'A');
                          },
                        ),
                        ListTile(
                          title: const Text('选项 B'),
                          onTap: () {
                            Navigator.pop(context, 'B');
                          },
                        ),
                        ListTile(
                          title: const Text('选项 C'),
                          onTap: () {
                            Navigator.pop(context, 'C');
                          },
                        ),
                      ],
                    ),
                  );
                },
                elevation: 4,
              );
            },
          ),
          ElevatedButton(
            child: const Text('showModalBottomSheet'),
            onPressed: () async {
              final String? result = await showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 200.0,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: const Text('选项 A'),
                          onTap: () {
                            Navigator.pop(context, 'A');
                          },
                        ),
                        ListTile(
                          title: const Text('选项 B'),
                          onTap: () {
                            Navigator.pop(context, 'B');
                          },
                        ),
                        ListTile(
                          title: const Text('选项 C'),
                          onTap: () {
                            Navigator.pop(context, 'C');
                          },
                        ),
                      ],
                    ),
                  );
                },
              );

              debugPrint('结果为: $result');
            },
          ),
          const SizedBox(
            height: 400,
          ),
          const Text('测试遮挡'),
        ],
      ),
    );
  }
}
