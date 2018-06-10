import 'package:flutter/material.dart';

// 分类阅读页面
class SearchPage extends StatefulWidget {
  static const String title = '搜索';
  static const Color color = Colors.blue;

  @override
  createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: SearchPage.color,
        automaticallyImplyLeading: false,
        title: Text(SearchPage.title),
      ),
      body: Center(
        child: Text(SearchPage.title),
      ),
    );
  }
}
