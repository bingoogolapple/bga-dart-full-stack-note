import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchPage extends StatefulWidget {
  @override
  _SwitchPageState createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
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
            CheckboxListTile(
              title: Text('是否设置 onChanged 回调'),
              value: _isEnable,
              onChanged: (isEnable) {
                setState(() {
                  _isEnable = isEnable;
                });
              },
            ),
            // onChanged 为空时为不可用状态，不为空时为可用状态
            // 创建 material design switch
            Switch(
              onChanged: _isEnable
                  ? (newValue) {
                      print('默认 Switch 选中状态变化 $newValue');
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
            // 作为 Column 的条目时是正常的，作为 ListView 条目时外部套 SizedBox 和 Container 无效，只能用 Transform.scale 来调整
            Transform.scale(
              scale: 0.8,
              child: Switch(
                onChanged: _isEnable
                    ? (newValue) {
                        print('默认 Switch 选中状态变化 $newValue');
                        setState(() {
                          _value = newValue;
                        });
                      }
                    : null,
                value: _value,
              ),
            ),
            Divider(
              height: 20,
            ),
            // 可以套一层 Row
            Row(
              children: <Widget>[
                Switch(
                  onChanged: _isEnable
                      ? (newValue) {
                          print('默认 Switch 选中状态变化 $newValue');
                          setState(() {
                            _value = newValue;
                          });
                        }
                      : null,
                  value: _value,
                )
              ],
            ),
            Switch(
              onChanged: _isEnable
                  ? (newValue) {
                      print('自定义1 Switch 选中状态变化 $newValue');
                      setState(() {
                        _value = newValue;
                      });
                    }
                  : null,
              value: _value,
              // 可用 && 选中时圆圈颜色
              activeColor: Colors.green,
              // 不可用 && (选中 || 未选中)时圆圈颜色
              inactiveThumbColor: Colors.pinkAccent,
              // 可用 && 选中时背景颜色
              activeTrackColor: Colors.cyanAccent,
              // 不可用 && (选中 || 未选中)时背景颜色
              inactiveTrackColor: Colors.orange,
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
            Switch(
              onChanged: _isEnable
                  ? (newValue) {
                      print('自定义2 Switch 选中状态变化 $newValue');
                      setState(() {
                        _value = newValue;
                      });
                    }
                  : null,
              value: _value,
              // 可用 && 选中时圆圈颜色
              activeColor: Colors.green,
              // 不可用 && (选中 || 未选中)时圆圈颜色
              inactiveThumbColor: Colors.pinkAccent,
              // 可用 && 选中时背景颜色
              activeTrackColor: Colors.cyanAccent,
              // 不可用 && (选中 || 未选中)时背景颜色
              inactiveTrackColor: Colors.orange,
              // 鼠标悬浮时圆圈周围大圆圈的背景色
              hoverColor: Colors.deepPurple,
              // 获取到输入焦点时的背景色
              focusColor: Colors.red,

              // 可用 && 选中时的圆圈图片，优先级大于 activeColor，如果设置的是网络图片的话，当滑块滑到大于中间位置时才开始加载
              activeThumbImage: AssetImage('packages/bga_flutter_package/images/BGA.png'),
              // 不可用 && (选中 || 未选中)时的圆圈图片，优先级大于 inactiveThumbColor，如果设置的是网络图片的话，当滑块滑到小于中间位置时才开始加载
              inactiveThumbImage: NetworkImage('https://avatars2.githubusercontent.com/u/20238146?s=200&v=4'),
            ),
            Divider(
              height: 20,
              color: Colors.red,
            ),
            // iOS 风格 switch
            CupertinoSwitch(
              onChanged: _isEnable
                  ? (newValue) {
                      print('默认 CupertinoSwitch 选中状态变化 $newValue');
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
            CupertinoSwitch(
              onChanged: _isEnable
                  ? (newValue) {
                      print('自定义 CupertinoSwitch 选中状态变化 $newValue');
                      setState(() {
                        _value = newValue;
                      });
                    }
                  : null,
              value: _value,
              // 选中时的背景颜色
              activeColor: Colors.orangeAccent,
            ),
            Divider(
              height: 20,
              color: Colors.red,
            ),
            /// iOS 平台为 iOS 风格的 switch，会忽略 activeTrackColor、inactiveThumbColor、inactiveTrackColor、activeThumbImage、inactiveThumbImage、materialTapTargetSize
            /// 其他平台全部为 material design switch
            Switch.adaptive(
              onChanged: _isEnable
                  ? (newValue) {
                print('默认 Switch.adaptive 选中状态变化 $newValue');
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
            Switch.adaptive(
              onChanged: _isEnable
                  ? (newValue) {
                print('自定义1 Switch.adaptive 选中状态变化 $newValue');
                setState(() {
                  _value = newValue;
                });
              }
                  : null,
              value: _value,
              // 可用 && 选中时圆圈颜色
              activeColor: Colors.green,
              // 不可用 && (选中 || 未选中)时圆圈颜色
              inactiveThumbColor: Colors.pinkAccent,
              // 可用 && 选中时背景颜色
              activeTrackColor: Colors.cyanAccent,
              // 不可用 && (选中 || 未选中)时背景颜色
              inactiveTrackColor: Colors.orange,
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
            Switch.adaptive(
              onChanged: _isEnable
                  ? (newValue) {
                print('自定义2 Switch.adaptive 选中状态变化 $newValue');
                setState(() {
                  _value = newValue;
                });
              }
                  : null,
              value: _value,
              // 可用 && 选中时圆圈颜色
              activeColor: Colors.green,
              // 不可用 && (选中 || 未选中)时圆圈颜色
              inactiveThumbColor: Colors.pinkAccent,
              // 可用 && 选中时背景颜色
              activeTrackColor: Colors.cyanAccent,
              // 不可用 && (选中 || 未选中)时背景颜色
              inactiveTrackColor: Colors.orange,
              // 鼠标悬浮时圆圈周围大圆圈的背景色
              hoverColor: Colors.deepPurple,
              // 获取到输入焦点时的背景色
              focusColor: Colors.red,

              // 可用 && 选中时的圆圈图片，优先级大于 activeColor，如果设置的是网络图片的话，当滑块滑到大于中间位置时才开始加载
              activeThumbImage: AssetImage('packages/bga_flutter_package/images/BGA.png'),
              // 不可用 && (选中 || 未选中)时的圆圈图片，优先级大于 inactiveThumbColor，如果设置的是网络图片的话，当滑块滑到小于中间位置时才开始加载
              inactiveThumbImage: NetworkImage('https://avatars2.githubusercontent.com/u/20238146?s=200&v=4'),
            ),
            Divider(
              height: 20,
              color: Colors.red,
            ),
            SwitchListTile(
              onChanged: _isEnable
                  ? (newValue) {
                print('默认 SwitchListTile 选中状态变化 $newValue');
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
            SwitchListTile(
              onChanged: _isEnable
                  ? (newValue) {
                print('自定义1 SwitchListTile 选中状态变化 $newValue');
                setState(() {
                  _value = newValue;
                });
              }
                  : null,
              value: _value,
              // 可用 && 选中时圆圈颜色
              // 可用时 title 和 subtitle 文字颜色、secondary 图标颜色
              // title 和 subtitle 为图标，secondary 为 文字时不会受影响
              activeColor: Colors.green,
              // 不可用 && (选中 || 未选中)时圆圈颜色
              inactiveThumbColor: Colors.pinkAccent,
              // 可用 && 选中时背景颜色
              activeTrackColor: Colors.cyanAccent,
              // 不可用 && (选中 || 未选中)时背景颜色
              inactiveTrackColor: Colors.orange,

              title: Text('标题'),
              subtitle: Text('子标题'),
              // text 和 icon 的颜色是否是 activeColor
              selected: true,
              // 左边的控件
              secondary: Icon(Icons.camera),
              // 内部空间间距
              contentPadding: EdgeInsets.all(30),
            ),
            Divider(
              height: 20,
            ),
            SwitchListTile(
              onChanged: _isEnable
                  ? (newValue) {
                print('自定义2 Switch.adaptive 选中状态变化 $newValue');
                setState(() {
                  _value = newValue;
                });
              }
                  : null,
              value: _value,
              // 可用 && 选中时圆圈颜色
              activeColor: Colors.green,
              // 不可用 && (选中 || 未选中)时圆圈颜色
              inactiveThumbColor: Colors.pinkAccent,
              // 可用 && 选中时背景颜色
              activeTrackColor: Colors.cyanAccent,
              // 不可用 && (选中 || 未选中)时背景颜色
              inactiveTrackColor: Colors.orange,

              // 可用 && 选中时的圆圈图片，优先级大于 activeColor，如果设置的是网络图片的话，当滑块滑到大于中间位置时才开始加载
              activeThumbImage: AssetImage('packages/bga_flutter_package/images/BGA.png'),
              // 不可用 && (选中 || 未选中)时的圆圈图片，优先级大于 inactiveThumbColor，如果设置的是网络图片的话，当滑块滑到小于中间位置时才开始加载
              inactiveThumbImage: NetworkImage('https://avatars2.githubusercontent.com/u/20238146?s=200&v=4'),

              // 是否展示的密集一些，为 true 时标题文字会变小，触摸区域也会变小
              dense: true,
              title: Icon(Icons.phone),
              subtitle: Icon(Icons.mail),
              selected: _value,
              // 为 true 时 title 和 subtitle 向上偏移，subtitle 不能为 null
              isThreeLine: true,
              // 左边的控件
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
