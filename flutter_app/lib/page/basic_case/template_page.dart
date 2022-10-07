import 'package:flutter/material.dart';

class TemplatePage extends StatelessWidget {
  const TemplatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString().replaceAll('Page', '')),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: const Text(''),
    );
  }
}
