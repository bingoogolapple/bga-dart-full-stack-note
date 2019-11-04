import 'package:bga_flutter_package/bga_flutter_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page/animated_page.dart';
import 'package:flutter_app/page/gesture_page.dart';
import 'package:flutter_app/page/input_page.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  void initState() {
    super.initState();
    print('initState => _MePageState');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        actions: _buildActions(),
      ),
      body: Container(
        child: Column(
          children: [
            Text(Calculator().addOne(5).toString()),
            BGALogoWidget(),
            MaterialButton(child: Text('手势识别'), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GesturePage()))),
            MaterialButton(child: Text('动画'), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AnimatedPage()))),
            MaterialButton(child: Text('表单输入'), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => InputPage()))),
          ],
        ),
      ),
    );
  }

  _buildActions() {
    return [
      IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          _showSnackBar('点击了设置');
        },
      ),
      PopupMenuButton<String>(
          offset: Offset(0, 200),
          color: Colors.deepOrangeAccent,
          // 默认是 ...
          icon: Icon(Icons.add),
          // child 和 icon 只能指定一个
          // child: Icon(Icons.add),
          onSelected: (value) {
            _showSnackBar('点击了$value');
          },
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                value: '添加朋友',
                textStyle: TextStyle(color: Colors.white),
                child: Row(children: [Icon(Icons.person_add), SizedBox(width: 10), Text('添加朋友')]),
              ),
              PopupMenuItem(
                value: '扫一扫',
                textStyle: TextStyle(color: Colors.white),
                child: Row(children: [Icon(Icons.camera_alt), SizedBox(width: 10), Text('扫一扫')]),
              )
            ];
          }),
    ];
  }

  void _showSnackBar(String text) {
    Scaffold.of(context).showSnackBar(
        SnackBar(behavior: SnackBarBehavior.floating, duration: Duration(seconds: 2), backgroundColor: Colors.deepOrangeAccent, content: Text(text)));
  }
}
