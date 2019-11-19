import 'package:flutter/material.dart';

class CheckboxPage extends StatefulWidget {
  @override
  _CheckboxPageState createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  bool _isEnable = false;
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkbox'),
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
            Checkbox(
              onChanged: _isEnable
                  ? (newValue) {
                      print('默认 Checkbox 选中状态变化 $newValue');
                      setState(() {
                        _value = newValue;
                      });
                    }
                  : null,
              value: _value,
            ),
            Divider(
              height: 20,
            ),
            Checkbox(
              /// 默认是 false，此时 value 必定不能是 null，false => true => false
              /// 设置为 true 时 value 可以为 null，界面上展示一个横杠，false => true => null => false
              tristate: true,
              onChanged: _isEnable
                  ? (newValue) {
                      print('横杠 Checkbox 选中状态变化 $newValue');
                      setState(() {
                        _value = newValue;
                      });
                    }
                  : null,
              value: null,
            ),
            Divider(
              height: 20,
            ),
            Checkbox(
              onChanged: _isEnable
                  ? (newValue) {
                      print('自定义 Checkbox 选中状态变化 $newValue');
                      setState(() {
                        _value = newValue;
                      });
                    }
                  : null,
              value: _value,
              // 可用&&选中时的背景色，默认是 ThemeData.toggleableActiveColor；不可用&&选中时默认为灰色，TODO 怎样修改？
              activeColor: Colors.green,
              // 可用||不可用选中时勾勾的颜色，默认为白色
              checkColor: Colors.cyanAccent,
              // 鼠标悬浮时的背景色
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
            // onChanged 为空时为不可用状态，不为空时为可用状态
            CheckboxListTile(
              onChanged: _isEnable
                  ? (newValue) {
                      print('默认 CheckboxListTile 选中状态变化 $newValue');
                      setState(() {
                        _value = newValue;
                      });
                    }
                  : null,
              value: _value,
            ),
            Divider(
              height: 20,
            ),
            CheckboxListTile(
              onChanged: _isEnable
                  ? (newValue) {
                      print('自定义1 CheckboxListTile 选中状态变化 $newValue');
                      setState(() {
                        _value = newValue;
                      });
                    }
                  : null,
              value: _value,
              // 没有 autofocus、focusNode、hoverColor、focusColor、materialTapTargetSize

              title: Text('标题'),
              subtitle: Text('子标题'),
              // text 和 icon 的颜色是否是 activeColor
              selected: true,
              // 左边的控件
              secondary: Icon(Icons.camera),
            ),
            Divider(
              height: 20,
            ),
            CheckboxListTile(
              onChanged: _isEnable
                  ? (newValue) {
                      print('自定义2 CheckboxListTile 选中状态变化 $newValue');
                      setState(() {
                        _value = newValue;
                      });
                    }
                  : null,
              value: _value,
              // 可用 && 选中时的背景色和 selected 为 true 时的标题、图标颜色，默认是 ThemeData.toggleableActiveColor；不可用&&选中时默认为灰色，TODO 怎样修改？
              activeColor: Colors.green,
              // (可用 || 不可用)&&选中时勾勾的颜色，默认为白色
              checkColor: Colors.cyanAccent,
              // 是否展示的密集一些，为 true 时标题文字会变小，触摸区域也会变小
              dense: true,
              title: Text('标题'),
              subtitle: Text('子标题'),
              selected: _value,
              // 为 true 时 title 和 subtitle 向上偏移，subtitle 不能为 null
              isThreeLine: true,
              // 左边的控件
              secondary: Icon(Icons.camera),
            ),
            Divider(
              height: 20,
            ),
            CheckboxListTile(
              onChanged: _isEnable
                  ? (newValue) {
                      print('自定义3 CheckboxListTile 选中状态变化 $newValue');
                      setState(() {
                        _value = newValue;
                      });
                    }
                  : null,
              value: _value,
              title: Text('可以\n显示\n多行'),
              subtitle: Text('controlAffinity\nleading:勾勾在左边\ntrailing:勾勾在右边\nplatform:根据不同平台来显示勾勾位置'),
              secondary: Icon(Icons.camera),
              // 试了下，Android、iOS、Web 都是 trailing
              controlAffinity: ListTileControlAffinity.leading,
            ),
            Divider(
              height: 20,
            ),
            CheckboxListTile(
              onChanged: _isEnable
                  ? (newValue) {
                      print('自定义4 CheckboxListTile 选中状态变化 $newValue');
                      setState(() {
                        _value = newValue;
                      });
                    }
                  : null,
              value: _value,
              title: Icon(Icons.phone),
              subtitle: Icon(Icons.mail),
              secondary: Text('title 或 subtitle 为 Icon 时会显示到中间'),
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
