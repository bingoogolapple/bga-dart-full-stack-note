import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'firstapp.dart';
import 'basic_widgets.dart';

//import 'material_components.dart';
import 'shopping.dart';
import 'layout_one.dart';
import 'layout_two.dart';
import 'layout_three.dart';
import 'layout_four.dart';
import 'layout_five.dart';
import 'layout_six.dart';
import 'navigation_passing_data.dart';
import 'package:flutter_note/list/list.dart';
import 'image.dart';
import 'gesture_detector.dart';
import 'net.dart';
import 'package:flutter_note/materialdesign/list.dart';

//void main() => runApp(BasicWidgetsApp());
//void main() => runApp(MaterialComponentsApp());
//void main() => runApp(ShoppingApp());
void main() {
//  debugPaintSizeEnabled=true;
//  runApp(LayoutOneApp());
//  runApp(LayoutTwoApp());
//  runApp(LayoutThreeApp());
//  runApp(LayoutFourApp());
//  runApp(LayoutFiveApp());
//  runApp(LayoutSixApp());
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
      ],
    );
  }
}
