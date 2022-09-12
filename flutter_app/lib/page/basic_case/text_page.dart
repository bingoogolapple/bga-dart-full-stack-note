import 'package:bga_flutter_package/bga_flutter_package.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Text.rich 和 Text 源码都是通过 RichText 实现的
class TextPage extends StatelessWidget {
  const TextPage({Key? key}) : super(key: key);

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
        title: const Text('Text'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Builder(builder: (context) {
        return ListView(
          children: [
            const TextSelectionTheme(
              // TextSelectionTheme 支持 TextField，不支持 Text
              data: TextSelectionThemeData(
                selectionColor: Colors.red, // 选中文字背景颜色
                selectionHandleColor: Colors.purple,
                cursorColor: Colors.blue, // 光标颜色
              ),
              child: TextField(),
            ),
            const Divider(
              height: 20,
            ),
            const SelectableText('我是SelectableText'),
            const Divider(
              height: 20,
            ),
            const SelectableText.rich(TextSpan(text: '我是SelectableText.rich')),
            const Divider(
              height: 20,
            ),
            const SelectionArea(
                child:
                    TextField()), // SelectionArea 支持 TextField 和 Text，也可以直接包裹到 Scaffold 外部
            const Divider(
              height: 20,
            ),
            const SelectionArea(
                child: Text(
              '我是SelectionArea包裹的Text',
            )),
            const Divider(
              height: 20,
            ),
            const Text(
              '测试TextStyle默认 hello world',
              textAlign: TextAlign.center,
            ),
            const Divider(
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
                shadows: const [
                  BoxShadow(
                      color: Colors.purple, offset: Offset(4, 4), blurRadius: 5)
                ],
                // text 背景色
                background: backgroundPaint,
                // text 前景色，不能与 color 同时设置
                foreground: foregroundPaint,
              ),
            ),
            const Divider(
              height: 20,
            ),
            Container(
              height: 120,
              color: Colors.deepPurple[200],
              child: Text.rich(
                TextSpan(
                  text: 'Text.rich默认黑色，测试换行',
                  children: [
                    const WidgetSpan(child: BGALogoWidget()),
                    const TextSpan(
                        text: '红色',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.normal)),
                    const TextSpan(
                        text: '粗体',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                    const TextSpan(
                        text: '斜体',
                        style: TextStyle(
                            color: Colors.blue, fontStyle: FontStyle.italic)),
                    TextSpan(
                      text: '中划线',
                      style: const TextStyle(
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
            const Divider(
              height: 20,
            ),
            Container(
              height: 120,
              color: Colors.deepPurple[200],
              child: RichText(
                text: TextSpan(
                  text: 'RichText默认白色，测试换行', // 手机和 Mac 默认是白色，在 web 上默认是黑色
                  children: [
                    const WidgetSpan(child: BGALogoWidget()),
                    const TextSpan(
                        text: '红色',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.normal)),
                    const TextSpan(
                        text: '粗体',
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold)),
                    const TextSpan(
                        text: '斜体',
                        style: TextStyle(
                            color: Colors.blue, fontStyle: FontStyle.italic)),
                    TextSpan(
                      text: '中划线',
                      style: const TextStyle(
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
            const Divider(
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
            const Divider(
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
            const Divider(
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
            const Divider(
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
            const Divider(
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
            const Divider(
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
            const Divider(
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
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.deepOrangeAccent,
        content: Text(text)));
  }
}
