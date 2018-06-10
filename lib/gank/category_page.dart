import 'package:flutter/material.dart';

// 分类阅读页面
class CategoryPage extends StatefulWidget {
  static const String title = '分类阅读';
  static const Color color = Colors.red;

  @override
  createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: CategoryPage.color,
        automaticallyImplyLeading: false,
        title: Text(CategoryPage.title),
      ),
      body: Center(
        child: Text(CategoryPage.title),
      ),
    );
  }
}
