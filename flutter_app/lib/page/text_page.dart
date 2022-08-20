import 'package:bga_flutter_package/bga_flutter_package.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Text.rich 和 Text 源码都是通过 RichText 实现的
class TextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Paint backgroundPaint = Paint();
    backgroundPaint.color = Colors.blue;
    backgroundPaint.style = PaintingStyle.stroke;
    Paint foregroundPaint = Paint();
    foregroundPaint.color = Colors.red;
    foregroundPaint.style = PaintingStyle.stroke;
    foregroundPaint.strokeWidth = 2;

    return Scaffold(
      appBar: AppBar(
        title: Text('Text'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Builder(builder: (context) {
        return ListView(
          children: [
            Text('测试TextStyle默认 hello world'),
            Divider(
              height: 20,
            ),
            Text(
              '测试TextStyle默认 hello world',
              style: TextStyle(
                // 单个字母或者汉字的距离
                letterSpacing: 2.0,
                // 单词之间添加的空间间隔
                wordSpacing: 8.0,
                fontSize: 30,
                shadows: [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(4, 4), blurRadius: 5)
                ],
                // text 背景色
                background: backgroundPaint,
                // text 前景色，不能与 color 同时设置
                foreground: foregroundPaint,
              ),
            ),
            Divider(
              height: 20,
            ),
            Container(
              height: 120,
              color: Colors.deepPurple[200],
              child: Text.rich(
                TextSpan(
                  text: 'Text.rich默认黑色，测试换行',
                  children: [
                    WidgetSpan(child: BGALogoWidget()),
                    TextSpan(
                        text: '红色',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.normal)),
                    TextSpan(
                        text: '粗体',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: '斜体',
                        style: TextStyle(
                            color: Colors.blue, fontStyle: FontStyle.italic)),
                    TextSpan(
                      text: '中划线',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationStyle: TextDecorationStyle.wavy,
                        decorationColor: Colors.red,
                        decorationThickness: 5,
                        // 字体大小，默认 14
                        fontSize: 18,
                        backgroundColor: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _showSnackBar(context, 'Text.rich 点击了中划线');
                        },
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 20,
            ),
            Container(
              height: 120,
              color: Colors.deepPurple[200],
              child: RichText(
                text: TextSpan(
                  text: 'RichText默认白色，测试换行',
                  children: [
                    WidgetSpan(child: BGALogoWidget()),
                    TextSpan(
                        text: '红色',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.normal)),
                    TextSpan(
                        text: '粗体',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: '斜体',
                        style: TextStyle(
                            color: Colors.blue, fontStyle: FontStyle.italic)),
                    TextSpan(
                      text: '中划线',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationStyle: TextDecorationStyle.wavy,
                        decorationColor: Colors.red,
                        decorationThickness: 5,
                        fontSize: 18,
                        backgroundColor: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _showSnackBar(context, 'RichText 点击了中划线');
                        },
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 20,
            ),
            Container(
              height: 60,
              color: Colors.deepPurple[100],
              child: Text(
                /// 超出容器宽度后是否自动换行，默认为 true，否则只有遇到 \n 时才换行
                /// 当 overflow 为 ellipsis 时，softWrap 无效
                'softWrap：超出容器宽度后是否自动换行，默认为 true ${'1' * 60}\n${'2' * 60}\n${'3' * 60}',
                softWrap: false,
              ),
            ),
            Divider(
              height: 20,
            ),
            Container(
              height: 60,
              color: Colors.deepPurple[100],
              child: Text(
                '设置 maxLines 后 TextOverflow.fade 和 TextOverflow.visible 不可用 ${'1' * 60}\n${'2' * 60}\n${'3' * 60}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Divider(
              height: 20,
            ),
            Container(
              height: 60,
              color: Colors.deepPurple[100],
              child: Text(
                'clip：默认值，超出容器的部分裁剪掉 ${'1' * 60}\n${'2' * 60}\n${'3' * 60}',
                overflow: TextOverflow.clip,
              ),
            ),
            Divider(
              height: 20,
            ),
            Container(
              height: 60,
              color: Colors.deepPurple[100],
              child: Text(
                'fade：超出容器的部分渐变不可见${'1' * 60}\n${'2' * 60}\n${'3' * 60}',
                overflow: TextOverflow.fade,
              ),
            ),
            Divider(
              height: 20,
            ),
            Container(
              height: 60,
              color: Colors.deepPurple[100],
              child: Text(
                'visible：超出容器的部分也会展示出来 ${'1' * 60}\n${'2' * 60}\n${'3' * 60}',
                overflow: TextOverflow.visible,
              ),
            ),
            Divider(
              height: 20,
            ),
            Container(
              height: 60,
              color: Colors.deepPurple[100],
              child: Text(
                'ellipsis：超出容器的部分点点点${'1' * 60}\n${'2' * 60}\n${'3' * 60}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Divider(
              height: 20,
            ),
          ],
        );
      }),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.deepOrangeAccent,
        content: Text(text)));
  }
}
