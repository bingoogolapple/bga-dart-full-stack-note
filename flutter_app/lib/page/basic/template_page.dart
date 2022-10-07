import 'package:flutter/material.dart';

class StlTemplatePage extends StatelessWidget {
  const StlTemplatePage({Key? key}) : super(key: key);

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

class StfTemplatePage extends StatefulWidget {
  const StfTemplatePage({super.key});

  @override
  State<StfTemplatePage> createState() => _StfTemplatePageState();
}

class _StfTemplatePageState extends State<StfTemplatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.runtimeType.toString().replaceAll('Page', '')),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: const Text(''),
    );
  }
}
