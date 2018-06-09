import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'firstapp.dart';
import 'basic_widgets.dart';

import 'shopping.dart';
import 'navigation_passing_data.dart';
import 'package:flutter_note/list/list.dart';
import 'image.dart';
import 'gesture_detector.dart';
import 'net.dart';
import 'package:flutter_note/materialdesign/list.dart';
import 'package:flutter_note/layout/list.dart';

void main() {
//  debugPaintSizeEnabled=true;

  runApp(FlutterNoteApp());
}

class FlutterNoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('FlutterNote'),
        ),
        body: new FlutterNoteList(),
      ),
    );
  }
}

class FlutterNoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text('FirstApp'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new FirstApp(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('ShoppingApp'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new ShoppingApp(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('列表'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new ListApp(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('界面跳转与传参'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new NavigationPassingDataApp(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('图片'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new ImageApp(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('处理手势'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new GestureDetectorApp(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('网络'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new NetApp(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('MaterialComponent'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new MaterialComponentApp(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('LayoutApp'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new LayoutApp(),
              ),
            );
          },
        ),
      ],
    );
  }
}
