import 'package:flutter/material.dart';

// https://flutterchina.club/tutorials/layout

class LayoutFourApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Lakes'),
      ),
      body: Center(child: buildGrid()),
    );
  }

  Widget buildGrid() {
    return GridView.extent(
        maxCrossAxisExtent: 150.0, // 创建最大宽度为150像素的网格
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: _buildGridTileList(30));
  }

  List<Container> _buildGridTileList(int count) {
    return List<Container>.generate(count, (index) => Container(child: Image.asset('images/grid/pic${index + 1}.jpg')));
  }
}
