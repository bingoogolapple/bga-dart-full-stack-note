import 'package:flutter/material.dart';

class DismissiblePage extends StatelessWidget {
  static final List<String> items =
      List<String>.generate(20, (i) => "滑动删除 ${i + 1}");

  const DismissiblePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString().replaceAll('Page', '')),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            key: Key(item),
            onDismissed: (direction) {
              debugPrint('onDismissed $direction');
              items.removeAt(index);
            },
            // 右滑背景
            background: Container(color: Colors.red),
            // 左滑背景
            secondaryBackground: Container(color: Colors.green),
            onResize: () {
              debugPrint('onResize');
            },
            onUpdate: (details) {
              debugPrint('onUpdate $details');
            },
            confirmDismiss: (DismissDirection direction) async {
              debugPrint('confirmDismiss $direction');
              return true;
            },
            direction: DismissDirection.horizontal,
            child: ListTile(title: Text(item)),
          );
        },
      ),
    );
  }
}
