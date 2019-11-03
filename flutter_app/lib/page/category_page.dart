import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  void initState() {
    super.initState();
    print('initState => _CategoryPageState');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分类'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        child: Center(
          child: Text(
            '分类',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }
}
