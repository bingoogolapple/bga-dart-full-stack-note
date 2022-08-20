import 'package:flutter/material.dart';

class ButtonPage extends StatefulWidget {
  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  bool _isEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Button'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Builder(builder: (context) {
        return ListView(
          children: [
            SwitchListTile(
              title: Text('是否设置 onPressed 回调'),
              value: _isEnable,
              onChanged: (isEnable) {
                setState(() {
                  _isEnable = isEnable;
                });
              },
            ),
            // 内部包裹的是 RawMaterialButton，MaterialButton 从 ButtonTheme 中获取默认配置
            MaterialButton(
              onPressed: _isEnable ? () => print('手指抬起后触发：点击了默认 MaterialButton') : null,
              onLongPress: _isEnable ? () => print('长按了默认 MaterialButton') : null,
              child: Text('onPressed 和 onLongPress 都为空时为不可用状态，有一个不为空时为可用状态(按下后有水波纹效果)'),
              onHighlightChanged: (highlight) {
                print('默认 onHighlightChanged $highlight');
              },
            ),
            Divider(
              height: 20,
            ),
            MaterialButton(
              onPressed: _isEnable ? () => print('手指抬起后触发：点击了自定义 MaterialButton') : null,
              onLongPress: _isEnable ? () => print('长按了自定义 MaterialButton') : null,
              child: Text('onPressed 和 onLongPress 都为空时为不可用状态，有一个不为空时为可用状态(按下后有水波纹效果)'),
              onHighlightChanged: (highlight) {
                print('自定义 onHighlightChanged $highlight');
              },
              // 可用&&未按下时的背景色
              color: Colors.green,
              // 不可用时的背景色
              disabledColor: Colors.blueGrey,
              // 按下、高亮时的背景色
              highlightColor: Colors.cyanAccent,
              // 鼠标悬浮时的背景色
              hoverColor: Colors.deepPurple,
              // 获取到输入焦点时的背景色
              focusColor: Colors.indigo,
              // 可用时的文字颜色
              textColor: Colors.yellow,
              // 不可用时的文字颜色
              disabledTextColor: Colors.orange,
              // 按下瞬间的颜色
              splashColor: Colors.red,
              colorBrightness: Brightness.light,

              // 默认阴影
              elevation: 2,
              // 不可用阴影，针对 MaterialButton 无效，在它子类有效（RaisedButton，FlatButton，OutlineButton）
              disabledElevation: 0,
              // 高亮时的阴影
              highlightElevation: 8,
              // 鼠标悬浮时的阴影
              hoverElevation: 4,
              // 获取到输入焦点时的阴影
              focusElevation: 4,

              // 高度
              height: 36,
              // 最新宽度
              minWidth: 88,

//              padding: EdgeInsets.all(16),

              // 是否有单击声音、长按震动反馈
              enableFeedback: true,
              // shape 和 elevation 动画时间
              animationDuration: kThemeChangeDuration,
              // 设置最小点击区域
              materialTapTargetSize: MaterialTapTargetSize.padded,

//              autofocus: false,
//              focusNode: FocusNode(),

              clipBehavior: Clip.none,
              shape: Border.all(color: Colors.black, style: BorderStyle.solid, width: 1),

//              this.shape,
//              this.clipBehavior = Clip.none,
            ),
            Divider(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _isEnable ? () => print('手指抬起后触发：点击了 RaisedButton') : null,
              child: Text('RaisedButton'),
            ),
            // 主要是为了弄成左边一个 icon 右面一个文字，这两个都是 Wight，所以可以任意定制
            ElevatedButton.icon(
              onPressed: _isEnable ? () => print('手指抬起后触发：点击了 RaisedButton.icon') : null,
              icon: Icon(Icons.camera),
              label: Text('RaisedButton.icon'),
              // 可用时的文字和图标颜色
              // textColor: Colors.blue,
              // 不可用时的文字和图标颜色
              // disabledTextColor: Colors.orange,
            ),
            Divider(
              height: 20,
            ),
            TextButton(
              onPressed: _isEnable ? () => print('手指抬起后触发：点击了 FlatButton') : null,
              child: Text('FlatButton'),
            ),
            // 主要是为了弄成左边一个 icon 右面一个文字，这两个都是 Wight，所以可以任意定制
            TextButton.icon(
              onPressed: _isEnable ? () => print('手指抬起后触发：点击了 FlatButton.icon') : null,
              icon: Icon(Icons.camera),
              label: Text('FlatButton.icon'),
              // 可用时的文字和图标颜色
              // textColor: Colors.blue,
              // 不可用时的文字和图标颜色
              // disabledTextColor: Colors.orange,
            ),
            Divider(
              height: 20,
            ),
            OutlinedButton(
              onPressed: _isEnable ? () => print('手指抬起后触发：点击了 OutlineButton') : null,
              child: Text('OutlineButton'),
            ),
            // 主要是为了弄成左边一个 icon 右面一个文字，这两个都是 Wight，所以可以任意定制
            OutlinedButton.icon(
              onPressed: _isEnable ? () => print('手指抬起后触发：点击了 OutlineButton.icon') : null,
              icon: Icon(Icons.camera),
              label: Text('OutlineButton.icon'),
              // 可用时的文字和图标颜色
              // textColor: Colors.blue,
              // 不可用时的文字和图标颜色
              // disabledTextColor: Colors.orange,

              // 下面三个为特有的属性
              // 高亮时的边框颜色
              // highlightedBorderColor: Colors.green,
              // 不可用时的边框颜色
              // disabledBorderColor: Colors.deepPurple,
              // 设置 shape 无效，需要通过 borderSide 来设置边框
              // borderSide: BorderSide(width: 1, color: Colors.black, style: BorderStyle.solid),
            ),
            Divider(
              height: 20,
            ),
            IconButton(
              onPressed: _isEnable ? () => print('手指抬起后触发：点击了 IconButton') : null,
              // 一般为 Icon 或 ImageIcon
              icon: Icon(Icons.camera),
            ),
            // 多用于 AppBar.actions 中，主要是为了弄成图标按钮，icon 属性是一个 Wight，所以可以任意定制
            IconButton(
              onPressed: _isEnable ? () => print('手指抬起后触发：点击了 OutlineButton.icon') : null,
              icon: Icon(Icons.camera),
              // 要通过 iconSize 来设置大小，直接设置 Icon 的 size 属性会导致按下后的背景色便宜
              iconSize: 40,
              // 可用时的图标颜色
              color: Colors.blue,
              // 不可用时的图标颜色
              disabledColor: Colors.orange,

              // 按下、高亮时的背景色
              highlightColor: Colors.cyanAccent,
              // 鼠标悬浮时的背景色
              hoverColor: Colors.deepPurple,
              // 获取到输入焦点时的背景色
              focusColor: Colors.indigo,
              // 按下瞬间的颜色
              splashColor: Colors.red,

              alignment: Alignment.center,

              padding: EdgeInsets.all(20),

              tooltip: '移动设备和浏览器长按后的提示文本，或浏览器鼠标悬浮时的文本',
            ),
            Divider(
              height: 20,
            ),
            PopupMenuButton<String>(
              // 是否可用
              enabled: true,
              // 默认是跟当前控件的左上角对齐
              offset: Offset(0, 200),
              tooltip: '移动设备和浏览器长按后的提示文本，或浏览器鼠标悬浮时的文本',
              // 浮窗背景色
              color: Colors.deepOrangeAccent,
              initialValue: '添加朋友',
              // 默认是 ...
              icon: Icon(Icons.add),
              // child 和 icon 只能指定一个
              // child: Icon(Icons.add),
              onSelected: (value) => print('点击了$value'),
              onCanceled: () => print('点击返回键或外部区域'),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<String>(
                    value: '添加朋友',
                    textStyle: TextStyle(color: Colors.white),
                    child: Row(children: [Icon(Icons.person_add), SizedBox(width: 10), Text('添加朋友')]),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    value: '扫一扫',
                    textStyle: TextStyle(color: Colors.white),
                    child: Row(children: [Icon(Icons.camera_alt), SizedBox(width: 10), Text('扫一扫')]),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    value: '联系人',
                    textStyle: TextStyle(color: Colors.white),
                    child: Row(children: [Icon(Icons.contacts), SizedBox(width: 10), Text('联系人')]),
                    // 是否可以选择
                    enabled: false,
                  ),
                  CheckedPopupMenuItem(
                    value: '测试选中',
                    checked: true,
                    child: Row(children: [Icon(Icons.contacts), SizedBox(width: 10), Text('测试选中')]),
                  ),
                  CheckedPopupMenuItem(
                    value: '测试未选中',
                    child: Row(children: [Icon(Icons.category), SizedBox(width: 10), Text('测试未选中')]),
                  )
                ];
              },
            ),
            Divider(
              height: 400,
            ),
          ],
        );
      }),
    );
  }
}
