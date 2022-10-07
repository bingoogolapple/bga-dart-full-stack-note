import 'package:flutter/material.dart';

class StackPage extends StatelessWidget {
  const StackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Stack'),
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
        ),
        body: Stack(
          alignment: Alignment.bottomRight,
          // fit: StackFit.expand,
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.red,
            ),
            Container(
              width: 150,
              height: 150,
              color: Colors.green,
            ),
            const Positioned(
              top: 30,
              right: 30,
              child: Icon(
                Icons.ac_unit,
                size: 32,
                color: Colors.blue,
              ),
            ),
            AspectRatio(
              aspectRatio: 10 / 2, // 设置宽高比为 10:2
              child: Container(
                width: 30, // 此时单独给 Container 的宽高无效
                height: 30,
                color: Colors.blue,
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 10,
                maxHeight: 40,
                minWidth: 10,
                maxWidth: 40,
              ),
              child: Container(color: Colors.purple),
            )
          ],
        ));
  }
}
