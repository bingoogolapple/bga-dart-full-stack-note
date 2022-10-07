import 'package:flutter/material.dart';

class RowColumnPage extends StatefulWidget {
  const RowColumnPage({super.key});

  @override
  State<RowColumnPage> createState() => _RowColumnPageState();
}

class _RowColumnPageState extends State<RowColumnPage> {
  /// Column 和 Row 都继承自 Flex

  /// 主轴对准方式，把 children 放到主轴的哪个位置。对于 Row 来说，水平是主轴，垂直是交叉轴。对于 Column 来说，垂直是主轴，水平是交叉轴
  /// MainAxisAlignment.start（默认值）把 children 放到主轴的头部
  /// MainAxisAlignment.center 把 children 放到主轴的中间
  /// MainAxisAlignment.end 把 children 放到主轴的尾部
  /// MainAxisAlignment.spaceAround 将主轴方向空白区域均分，使得 children 之间空间相等，但是首尾 children 的空白部分为一半
  /// MainAxisAlignment.spaceBetween 将主轴方向空白区域均分，使得 children 之间空间相等，但是首尾 children 靠近首尾，没有空隙
  /// MainAxisAlignment.spaceEvenly 将主轴方向空白区域均分，使得 children 之间空间相等，包括首尾 children
  /// 生效的前提是大于子控件总的大小
  MainAxisAlignment _mainAxisAlignment = MainAxisAlignment.start;

  /// 包裹子控件还是填充父容器
  /// MainAxisSize.max（默认值）填充父容器
  /// MainAxisSize.min 包裹子容器
  MainAxisSize _mainAxisSize = MainAxisSize.max;

  /// 交叉轴对准方式，把 children 放到交叉轴的哪个位置。对于 Row 来说，水平是主轴，垂直是交叉轴。对于 Column 来说，垂直是主轴，水平是交叉轴
  /// CrossAxisAlignment.center（默认值）把 children 放到交叉轴的中间
  /// CrossAxisAlignment.start 把 children 放到交叉轴的头部
  /// CrossAxisAlignment.end 把 children 放到交叉轴的尾部
  /// CrossAxisAlignment.stretch 让 children 填满交叉轴方向
  /// CrossAxisAlignment.baseline 让 children 与 baseline 对齐，如果主轴是垂直的，那么这个值是当作开始 ，设置了此属性 textBaseline 不能为 null
  CrossAxisAlignment _crossAxisAlignment = CrossAxisAlignment.center;

  /// 默认值为 null
  /// TextBaseline.alphabetic 对齐字母字符底部的水平线
  /// TextBaseline.ideographic 对齐表意字符的水平线
  TextBaseline _textBaseline = TextBaseline.alphabetic;

  /// 控制 children 水平方向怎样排列。从左到右排列还是从右到左排列
  /// 默认为 null，系统当前 Locale 环境的文本方向（如中文、英文都是从左到右，而阿拉伯语是从右到左）
  /// TextDirection.ltr 从左到右排列
  /// TextDirection.rtl 从右到左排列
  TextDirection _textDirection = TextDirection.ltr;

  /// 控制 children 竖直方向怎样排列。从上到下排列还是从下到上排列
  /// VerticalDirection.down（默认值）从上到下排列
  /// VerticalDirection.up 从下到上排列
  VerticalDirection _verticalDirection = VerticalDirection.down;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RowColumn'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Wrap(
                  children: [
                    PopupMenuButton<MainAxisAlignment>(
                      initialValue: _mainAxisAlignment,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(_mainAxisAlignment.toString())),
                      onSelected: (item) =>
                          setState(() => _mainAxisAlignment = item),
                      itemBuilder: (context) => MainAxisAlignment.values
                          .map((item) => PopupMenuItem(
                              value: item, child: Text(item.toString())))
                          .toList(),
                    ),
                    PopupMenuButton<MainAxisSize>(
                      initialValue: _mainAxisSize,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(_mainAxisSize.toString())),
                      onSelected: (item) =>
                          setState(() => _mainAxisSize = item),
                      itemBuilder: (context) => MainAxisSize.values
                          .map((item) => PopupMenuItem(
                              value: item, child: Text(item.toString())))
                          .toList(),
                    ),
                    PopupMenuButton<CrossAxisAlignment>(
                      initialValue: _crossAxisAlignment,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(_crossAxisAlignment.toString())),
                      onSelected: (item) =>
                          setState(() => _crossAxisAlignment = item),
                      itemBuilder: (context) => CrossAxisAlignment.values
                          .map((item) => PopupMenuItem(
                              value: item, child: Text(item.toString())))
                          .toList(),
                    ),
                    PopupMenuButton<VerticalDirection>(
                      initialValue: _verticalDirection,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(_verticalDirection.toString())),
                      onSelected: (item) =>
                          setState(() => _verticalDirection = item),
                      itemBuilder: (context) => VerticalDirection.values
                          .map((item) => PopupMenuItem(
                              value: item, child: Text(item.toString())))
                          .toList(),
                    ),
                    PopupMenuButton<TextDirection>(
                      initialValue: _textDirection,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(_textDirection.toString())),
                      onSelected: (item) =>
                          setState(() => _textDirection = item),
                      itemBuilder: (context) => TextDirection.values
                          .map((item) => PopupMenuItem(
                              value: item, child: Text(item.toString())))
                          .toList(),
                    ),
                    PopupMenuButton<TextBaseline>(
                      initialValue: _textBaseline,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(_textBaseline.toString())),
                      onSelected: (item) =>
                          setState(() => _textBaseline = item),
                      itemBuilder: (context) => TextBaseline.values
                          .map((item) => PopupMenuItem(
                              value: item, child: Text(item.toString())))
                          .toList(),
                    ),
                  ],
                ),
                const Divider(
                  height: 20,
                ),
                Container(
                  color: Colors.orange,
                  child: Row(
                    mainAxisAlignment: _mainAxisAlignment,
                    mainAxisSize: _mainAxisSize,
                    crossAxisAlignment: _crossAxisAlignment,
                    verticalDirection: _verticalDirection,
                    textDirection: _textDirection,
                    textBaseline: _textBaseline,
                    children: const [
                      Text('yAja啊'),
                      Text('yBjb吧', style: TextStyle(fontSize: 30)),
                      Text('yCjc从', style: TextStyle(fontSize: 10)),
                      Icon(Icons.camera, size: 30),
                    ],
                  ),
                ),
                const Divider(
                  height: 20,
                ),
                Container(
                  color: Colors.green,
                  width: 250,
                  height: 250,
                  child: Row(
                    mainAxisAlignment: _mainAxisAlignment,
                    mainAxisSize: _mainAxisSize,
                    crossAxisAlignment: _crossAxisAlignment,
                    verticalDirection: _verticalDirection,
                    textDirection: _textDirection,
                    textBaseline: _textBaseline,
                    children: const [
                      Text('yAja啊'),
                      Text('yBjb吧', style: TextStyle(fontSize: 30)),
                      Text('yCjc从', style: TextStyle(fontSize: 10)),
                      Icon(Icons.camera, size: 30),
                    ],
                  ),
                ),
                const Divider(
                  height: 20,
                ),
                Container(
                  color: Colors.purple,
                  width: 250,
                  height: 250,
                  child: Column(
                    mainAxisAlignment: _mainAxisAlignment,
                    mainAxisSize: _mainAxisSize,
                    crossAxisAlignment: _crossAxisAlignment,
                    verticalDirection: _verticalDirection,
                    textDirection: _textDirection,
                    textBaseline: _textBaseline,
                    children: const [
                      Text('yAja啊'),
                      Text('yBjb吧', style: TextStyle(fontSize: 30)),
                      Text('yCjc从', style: TextStyle(fontSize: 10)),
                      Icon(Icons.camera, size: 30),
                    ],
                  ),
                ),
                const Divider(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
