import 'package:flutter/material.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({Key? key}) : super(key: key);

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  bool _isEnable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed:
      //       _isEnable ? () => debugPrint('点击 FloatingActionButton') : null,
      //   backgroundColor: Colors.blue,
      //   shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(15)),
      //   child: const Icon(Icons.add),
      // ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => debugPrint('点击 FloatingActionButton'),
        backgroundColor: Colors.pink,
        // RoundedRectangleBorder ContinuousRectangleBorder BeveledRectangleBorder CircleBorder
        // shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
        // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shape: const StadiumBorder(),
        icon: const Icon(Icons.add),
        label: const Text('添加'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 80,
          // color: Colors.pinkAccent,
        ),
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('是否设置 onPressed 回调'),
                subtitle: const Text('我是子标题'),
                secondary: const Text('secondary'),
                value: _isEnable,
                selected: _isEnable,
                onChanged: (isEnable) {
                  setState(() {
                    _isEnable = isEnable;
                  });
                },
              ),
              // 内部包裹的是 RawMaterialButton，MaterialButton 从 ButtonTheme 中获取默认配置
              MaterialButton(
                onPressed: _isEnable
                    ? () => debugPrint('手指抬起后触发：点击了自定义 MaterialButton')
                    : null,
                onLongPress: _isEnable
                    ? () => debugPrint('长按了自定义 MaterialButton')
                    : null,
                onHighlightChanged: (highlight) {
                  debugPrint('自定义 onHighlightChanged $highlight');
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
                // 最小宽度
                minWidth: 88,

                padding: const EdgeInsets.all(16),

                // 是否有单击声音、长按震动反馈
                enableFeedback: true,
                // shape 和 elevation 动画时间
                animationDuration: kThemeChangeDuration,
                // 设置最小点击区域
                materialTapTargetSize: MaterialTapTargetSize.padded,

                //  autofocus: false,
                //  focusNode: FocusNode(),

                clipBehavior: Clip.none,
                shape: Border.all(
                    color: Colors.red, style: BorderStyle.solid, width: 2),
                child: const Text(
                    'MaterialButton, onPressed 和 onLongPress 都为空时为不可用状态，有一个不为空时为可用状态(按下后有水波纹效果)'),
              ),
              const Divider(
                height: 20,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isEnable
                        ? () => debugPrint('手指抬起后触发：点击了 ElevatedButton')
                        : null,
                    onLongPress: _isEnable
                        ? () => debugPrint('长按了 ElevatedButton')
                        : null,
                    onHover: (hover) {
                      debugPrint('ElevatedButton onHover $hover');
                    },
                    child: const Text('ElevatedButton'),
                  ),
                  ElevatedButton(
                    onPressed: _isEnable
                        ? () => debugPrint('手指抬起后触发：点击了 ElevatedButton')
                        : null,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        const StadiumBorder(
                          side: BorderSide(width: 2, color: Colors.amber),
                        ),
                      ),
                    ),
                    child: const Text('ElevatedButton'),
                  ),
                  ElevatedButton(
                    onPressed: _isEnable
                        ? () => debugPrint('手指抬起后触发：点击了 ElevatedButton')
                        : null,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey), // 背景颜色
                      foregroundColor:
                          MaterialStateProperty.all(Colors.white), // 字体颜色
                      overlayColor:
                          MaterialStateProperty.all(Colors.amber), // 高亮色
                      shadowColor:
                          MaterialStateProperty.all(Colors.purple), // 阴影颜色
                      elevation: MaterialStateProperty.all(3), // 阴影值
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 12), // 字体
                      ),
                      // 边框，这里的 side 会覆盖 shape 中的边框设置
                      // side: MaterialStateProperty.all(
                      //   const BorderSide(
                      //     width: 1,
                      //     color: Colors.red,
                      //   ),
                      // ),
                      shape: MaterialStateProperty.all(
                        BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(width: 2, color: Colors.amber),
                        ),
                      ),
                      // shape: MaterialStateProperty.all(
                      //   const CircleBorder(
                      //     side: BorderSide(width: 2, color: Colors.amber),
                      //   ),
                      // ),
                      // shape: MaterialStateProperty.all(
                      //   const StadiumBorder(
                      //     side: BorderSide(width: 2, color: Colors.amber),
                      //   ),
                      // ),
                    ),
                    child: const Text('ElevatedButton'),
                  ),
                  // 主要是为了弄成左边一个 icon 右面一个文字，这两个都是 Wight，所以可以任意定制
                  ElevatedButton.icon(
                    onPressed: _isEnable
                        ? () => debugPrint('手指抬起后触发：点击了 ElevatedButton.icon')
                        : null,
                    onLongPress: _isEnable
                        ? () => debugPrint('长按了 ElevatedButton.icon')
                        : null,
                    onHover: (hover) {
                      debugPrint('ElevatedButton.icon onHover $hover');
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text('ElevatedButton.icon'),
                    // 可用时的文字和图标颜色
                    // textColor: Colors.blue,
                    // 不可用时的文字和图标颜色
                    // disabledTextColor: Colors.orange,
                  ),
                ],
              ),
              const Divider(
                height: 20,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _isEnable
                        ? () => debugPrint('手指抬起后触发：点击了 TextButton')
                        : null,
                    onLongPress:
                        _isEnable ? () => debugPrint('长按了 TextButton') : null,
                    onHover: (hover) {
                      debugPrint('TextButton onHover $hover');
                    },
                    child: const Text('TextButton'),
                  ),
                  // 主要是为了弄成左边一个 icon 右面一个文字，这两个都是 Wight，所以可以任意定制
                  TextButton.icon(
                    onPressed: _isEnable
                        ? () => debugPrint('手指抬起后触发：点击了 TextButton.icon')
                        : null,
                    onLongPress: _isEnable
                        ? () => debugPrint('长按了 TextButton.icon')
                        : null,
                    onHover: (hover) {
                      debugPrint('TextButton.icon onHover $hover');
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text('TextButton.icon'),
                    // 可用时的文字和图标颜色
                    // textColor: Colors.blue,
                    // 不可用时的文字和图标颜色
                    // disabledTextColor: Colors.orange,
                  ),
                ],
              ),
              const Divider(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1, // 占用 1 份
                    child: OutlinedButton(
                      onPressed: _isEnable
                          ? () => debugPrint('手指抬起后触发：点击了 OutlinedButton')
                          : null,
                      onLongPress: _isEnable
                          ? () => debugPrint('长按了 OutlinedButton')
                          : null,
                      onHover: (hover) {
                        debugPrint('OutlinedButton onHover $hover');
                      },
                      child: const Text('OutlinedButton'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // 主要是为了弄成左边一个 icon 右面一个文字，这两个都是 Wight，所以可以任意定制
                  Expanded(
                    flex: 2, // 占用 2 份
                    child: OutlinedButton.icon(
                      onPressed: _isEnable
                          ? () => debugPrint('手指抬起后触发：点击了 OutlineButton.icon')
                          : null,
                      onLongPress: _isEnable
                          ? () => debugPrint('长按了 OutlinedButton.icon')
                          : null,
                      icon: const Icon(Icons.camera),
                      label: const Text('OutlineButton.icon'),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 20,
              ),
              IconButton(
                onPressed: _isEnable
                    ? () => debugPrint('手指抬起后触发：点击了 IconButton')
                    : null,
                // 一般为 Icon 或 ImageIcon
                icon: const Icon(Icons.camera),
              ),
              // 多用于 AppBar.actions 中，主要是为了弄成图标按钮，icon 属性是一个 Wight，所以可以任意定制
              IconButton(
                onPressed: _isEnable
                    ? () => debugPrint('手指抬起后触发：点击了 OutlineButton.icon')
                    : null,
                icon: const Icon(Icons.camera),
                // 要通过 iconSize 来设置大小，直接设置 Icon 的 size 属性会导致按下后的背景色偏移
                iconSize: 60,
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

                padding: const EdgeInsets.all(20),
                tooltip: '移动设备和浏览器长按后的提示文本，或浏览器鼠标悬浮时的文本',
              ),
              const Divider(
                height: 20,
              ),
              PopupMenuButton<String>(
                // 是否可用
                enabled: true,
                // 默认是跟当前控件的左上角对齐
                offset: const Offset(0, 200),
                tooltip: '移动设备和浏览器长按后的提示文本，或浏览器鼠标悬浮时的文本',
                // 浮窗背景色
                color: Colors.deepOrangeAccent,
                initialValue: '添加朋友',
                // 默认是 ...
                // icon: const Icon(Icons.add),
                // child 和 icon 只能指定一个
                child: const Text('PopupMenuButton'),
                onSelected: (value) => debugPrint('点击了$value'),
                onCanceled: () => debugPrint('点击返回键或外部区域'),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<String>(
                      value: '添加朋友',
                      textStyle: const TextStyle(color: Colors.white),
                      child: Row(children: const [
                        Icon(Icons.person_add),
                        SizedBox(width: 10),
                        Text('添加朋友')
                      ]),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem(
                      value: '扫一扫',
                      textStyle: const TextStyle(color: Colors.white),
                      child: Row(children: const [
                        Icon(Icons.camera_alt),
                        SizedBox(width: 10),
                        Text('扫一扫')
                      ]),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem(
                      value: '联系人',
                      textStyle: const TextStyle(color: Colors.white),
                      // 是否可以选择
                      enabled: false,
                      child: Row(children: const [
                        Icon(Icons.contacts),
                        SizedBox(width: 10),
                        Text('联系人')
                      ]),
                    ),
                    CheckedPopupMenuItem(
                      value: '测试选中',
                      checked: true,
                      child: Row(children: const [
                        Icon(Icons.contacts),
                        SizedBox(width: 10),
                        Text('测试选中')
                      ]),
                    ),
                    CheckedPopupMenuItem(
                      value: '测试未选中',
                      child: Row(children: const [
                        Icon(Icons.category),
                        SizedBox(width: 10),
                        Text('测试未选中')
                      ]),
                    )
                  ];
                },
              ),
              const Divider(
                height: 400,
              ),
            ],
          ),
        );
      }),
    );
  }
}
