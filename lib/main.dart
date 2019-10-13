import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_note/note/animated.dart';

import 'package:flutter_note/note/firstapp.dart';
import 'package:flutter_note/note/basic_widgets.dart';
import 'package:flutter_note/note/shopping.dart';
import 'package:flutter_note/note/navigation_passing_data.dart';
import 'package:flutter_note/note/list/list.dart';
import 'package:flutter_note/note/image.dart';
import 'package:flutter_note/note/gesture_detector.dart';
import 'package:flutter_note/note/net.dart';
import 'package:flutter_note/note/materialdesign/list.dart';
import 'package:flutter_note/note/layout/list.dart';
import 'package:flutter_note/gank/gank.dart';
import 'package:flutter_note/note/input.dart';

void main() {
//  debugPaintSizeEnabled=true;

  runApp(FlutterNoteApp());
}

class FlutterNoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 跳转到其他页面后如果不想展示返回按钮，可以把 MaterialApp 再作为他页面的根 Widget
    return MaterialApp(
//      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('FlutterNote'),
          backgroundColor: defaultTargetPlatform == TargetPlatform.iOS ? Colors.lightBlue : Colors.lightGreen, // 判断平台类型需要使用 foundation 包
        ),
        body: new FlutterNoteList(),
      ),
      routes: <String, WidgetBuilder>{
        '/firstapp': (BuildContext context) => new FirstApp(),
      },
    );
  }
}

class FlutterNoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(title: Text('干货集中营'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => new GankApp()))),
        ListTile(
            title: Text('FirstApp'),
            onTap: () {
              Navigator.pushNamed(context, '/firstapp');
//              Navigator.push(context, MaterialPageRoute(builder: (context) => new FirstApp()));
            }),
        ListTile(title: Text('ShoppingApp'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => new ShoppingApp()))),
        ListTile(title: Text('列表'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => new ListApp()))),
        ListTile(title: Text('界面跳转与传参'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => new NavigationApp()))),
        ListTile(title: Text('图片'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => new ImageApp()))),
        ListTile(title: Text('处理手势'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => new GestureEventApp()))),
        ListTile(title: Text('网络'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => new NetApp()))),
        ListTile(title: Text('MaterialComponent'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => new MaterialComponentApp()))),
        ListTile(title: Text('LayoutApp'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => new LayoutApp()))),
        ListTile(title: Text('InputApp'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => new InputApp()))),
        ListTile(title: Text('AnimDemo'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => new AnimApp()))),
      ],
    );
  }
}
