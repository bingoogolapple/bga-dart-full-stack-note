import 'package:flutter/material.dart';

class ChildView extends StatefulWidget {
  final String desc;
  final bool hasAppBar;
  const ChildView({super.key, required this.hasAppBar, required this.desc});

  @override
  State<ChildView> createState() => _ChildViewState();
}

// AutomaticKeepAliveClientMixin：wantKeepAlive => initState => wantKeepAlive
// PageView、TabBarView（内部是基于 TabBarView 实现的，封装了 TabBar 和 PageView 的联动逻辑）：只会初始化当前选中页
//     子页面不结合 AutomaticKeepAliveClientMixin 一起使用：后续切换页码时会重新初始化
//     子页面结合 AutomaticKeepAliveClientMixin 一起使用：后续切换页码时不会重新初始化
// IndexedStack：不管是否结合 AutomaticKeepAliveClientMixin 使用，都会初始化所有子页面，后续切换页码时不会重新初始化
class _ChildViewState extends State<ChildView>
    with AutomaticKeepAliveClientMixin {
// class _ChildViewState extends State<ChildView> {
  @override
  bool get wantKeepAlive {
    debugPrint('${runtimeType.toString()} ${widget.desc} wantKeepAlive');
    return true;
  }

  @override
  void initState() {
    super.initState();
    debugPrint('${runtimeType.toString()} ${widget.desc} initState');
  }

  @override
  Widget build(BuildContext context) {
    // 使用 AutomaticKeepAliveClientMixin 保持页面状态时，必须调用 super.build(context)
    super.build(context);

    if (widget.hasAppBar) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.desc),
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
        ),
        body: Center(child: Text(widget.desc)),
      );
    }

    return Center(child: Text(widget.desc));
  }
}
