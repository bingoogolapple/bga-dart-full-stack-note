import 'package:bga_flutter_package/bga_flutter_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page/animated_page.dart';
import 'package:flutter_app/page/button_page.dart';
import 'package:flutter_app/page/checkbox_page.dart';
import 'package:flutter_app/page/gesture_page.dart';
import 'package:flutter_app/page/http_page.dart';
import 'package:flutter_app/page/input_page.dart';
import 'package:flutter_app/page/radio_page.dart';
import 'package:flutter_app/page/switch_page.dart';
import 'package:flutter_app/page/text_page.dart';
import 'package:flutter_app/widget/banner_widget.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive {
    print('wantKeepAlive _MePageState');
    return true;
  }

  @override
  void initState() {
    super.initState();
    print('initState => _MePageState');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
            MaterialButton(
              color: Colors.yellow,
              child: Text('Radio'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RadioPage())),
            ),
            MaterialButton(
              color: Colors.yellow,
              child: Text('Switch'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SwitchPage())),
            ),
            MaterialButton(
              color: Colors.yellow,
              child: Text('Checkbox'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CheckboxPage())),
            ),
            MaterialButton(
              color: Colors.yellow,
              child: Text('Button'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ButtonPage())),
            ),
            MaterialButton(
              color: Colors.yellow,
              child: Text('Text'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TextPage())),
            ),
            MaterialButton(
              color: Colors.yellow,
              child: Text('手势识别'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GesturePage())),
            ),
            MaterialButton(
              color: Colors.yellow,
              child: Text('动画'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AnimatedPage())),
            ),
            MaterialButton(
              color: Colors.yellow,
              child: Text('表单输入'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => InputPage())),
            ),
            MaterialButton(
              color: Colors.yellow,
              child: Text('HTTP'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HttpPage())),
            ),
            Container(
              height: 80,
              child: BannerWidget(
                List.generate(4, (index) {
                  return 'http://bgashare.bingoogolapple.cn/banner/imgs/${index + 1}.png';
                }),
                Colors.deepOrange,
              ),
            ),
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
