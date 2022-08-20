import 'package:flutter/material.dart';

class RadioPage extends StatefulWidget {
  @override
  _RadioPageState createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  bool _isEnable = false;
  String _groupValue = 'A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radio'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Builder(builder: (context) {
        return ListView(
          children: [
            SwitchListTile(
              title: Text('是否设置 onChanged 回调'),
              value: _isEnable,
              onChanged: (isEnable) {
                setState(() {
                  _isEnable = isEnable;
                });
              },
            ),
            // onChanged 为空时为不可用状态，不为空时为可用状态
            Radio(
              onChanged: _isEnable
                  ? (newValue) {
                      print('默认 Radio 选中状态变化 $newValue');
                      setState(() {
                        _groupValue = newValue as String;
                      });
                    }
                  : null,
              value: 'A',
              groupValue: _groupValue,
            ),
            Divider(
              height: 20,
            ),
            Radio(
              onChanged: _isEnable
                  ? (newValue) {
                      print('自定义 Radio 选中状态变化 $newValue');
                      setState(() {
                        _groupValue = newValue as String;
                      });
                    }
                  : null,
              value: 'B',
              groupValue: _groupValue,

              // 可用 && 选中时圆圈颜色
              activeColor: Colors.green,
              // 鼠标悬浮时圆圈周围大圆圈的背景色
              hoverColor: Colors.deepPurple,
              // 获取到输入焦点时的背景色
              focusColor: Colors.red,

              // 设置最小点击区域
              materialTapTargetSize: MaterialTapTargetSize.padded,
//              autofocus: false,
//              focusNode: FocusNode(),
            ),
            Divider(
              height: 20,
            ),
            // 作为 Column 的条目时是正常的，作为 ListView 条目时外部套 SizedBox 和 Container 无效，只能用 Transform.scale 来调整
            Transform.scale(
              scale: 0.8,
              child: Radio(
                onChanged: _isEnable
                    ? (newValue) {
                        setState(() {
                          _groupValue = newValue as String;
                        });
                      }
                    : null,
                value: 'C',
                groupValue: _groupValue,
              ),
            ),
            Divider(
              height: 20,
            ),
            // 可以套一层 Row
            Row(
              children: <Widget>[
                Radio(
                  onChanged: _isEnable
                      ? (newValue) {
                          print('默认 Switch 选中状态变化 $newValue');
                          setState(() {
                            _groupValue = newValue as String;
                          });
                        }
                      : null,
                  value: 'D',
                  groupValue: _groupValue,
                )
              ],
            ),
            Divider(
              height: 20,
            ),
            RadioListTile(
              onChanged: _isEnable
                  ? (newValue) {
                      print('默认 RadioListTile 选中状态变化 $newValue');
                      setState(() {
                        _groupValue = newValue as String;
                      });
                    }
                  : null,
              value: 'A',
              groupValue: _groupValue,
            ),
            Divider(
              height: 20,
            ),
            RadioListTile(
              onChanged: _isEnable
                  ? (newValue) {
                      print('自定义1 RadioListTile 选中状态变化 $newValue');
                      setState(() {
                        _groupValue = newValue as String;
                      });
                    }
                  : null,
              value: 'B',
              groupValue: _groupValue,

              // 可用 && 选中时圆圈颜色
              activeColor: Colors.green,

              title: Text('标题'),
              subtitle: Text('子标题'),
              // title 和 subtitle 为 text 时的颜色是否是 activeColor
              // secondary 为 icon 时的颜色是否是 activeColor
              selected: true,
              // 右边的控件
              secondary: Text('右边控件'),
              // 是否展示的密集一些，为 true 时标题文字会变小，触摸区域也会变小
              dense: true,
            ),
            Divider(
              height: 20,
            ),
            RadioListTile(
              onChanged: _isEnable
                  ? (newValue) {
                      print('自定义2 RadioListTile 选中状态变化 $newValue');
                      setState(() {
                        _groupValue = newValue as String;
                      });
                    }
                  : null,
              value: 'C',
              groupValue: _groupValue,

              // 可用 && 选中时圆圈颜色
              activeColor: Colors.green,

              title: Icon(Icons.camera),
              subtitle: Icon(Icons.camera),
              // title 和 subtitle 为 text 时的颜色是否是 activeColor
              // secondary 为 icon 时的颜色是否是 activeColor
              selected: true,
              // 右边的控件
              secondary: Icon(Icons.camera),
            ),
            Divider(
              height: 20,
            ),
            RadioListTile(
              onChanged: _isEnable
                  ? (newValue) {
                      setState(() {
                        _groupValue = newValue as String;
                      });
                    }
                  : null,
              value: 'D',
              groupValue: _groupValue,

              title: Text('标题'),
              subtitle: Text('子标题'),

              // 为 true 时 title 和 subtitle 向上偏移，subtitle 不能为 null
              isThreeLine: true,

              // 右边的控件
              secondary: Icon(Icons.camera),

              controlAffinity: ListTileControlAffinity.trailing,
            ),
            Divider(
              height: 20,
            ),
          ],
        );
      }),
    );
  }
}
