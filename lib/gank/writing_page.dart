import 'package:flutter/material.dart';

// 分类阅读页面
class WritingPage extends StatefulWidget {
  static const String title = '匠心写作';
  static const Color color = Colors.purple;

  @override
  createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: WritingPage.color,
        automaticallyImplyLeading: false,
        title: Text(WritingPage.title),
      ),
      body: Center(
        child: Text(WritingPage.title),
      ),
    );
  }
}
