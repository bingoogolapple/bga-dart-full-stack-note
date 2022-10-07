import 'package:flutter/material.dart';
import 'package:flutter_app/page/demo/home_page/child_view.dart';
import 'package:flutter_app/utils/no_over_scroll_behavior.dart';

class TabBarAndTabBarView extends StatefulWidget {
  const TabBarAndTabBarView({super.key});

  @override
  State<TabBarAndTabBarView> createState() => _TabBarAndTabBarViewState();
}

class _TabBarAndTabBarViewState extends State<TabBarAndTabBarView>
    with TickerProviderStateMixin {
  static final _tabList = [
    const Tab(
      // 非必填（但是 icon、text、child 不能全为空），条目图标
      icon: Icon(Icons.one_k),
      // 非必填（但是 icon、text、child 不能全为空），条目文案
      text: 'One',
      // child 和 text 只能指定一个
      // child: Icon(Icons.more),
      // 非必填，条目高度，默认为 46 或 72
      height: 72,
      // 非必填，图标外边距，默认为 EdgeInsets.only(bottom: 10)
      iconMargin: EdgeInsets.only(bottom: 10),
    ),
    const Tab(icon: Icon(Icons.two_k), text: 'Two'),
    const Tab(icon: Icon(Icons.three_k), text: 'Three'),
    const Tab(icon: Icon(Icons.four_k), text: 'Four'),
  ];
  static final List<Widget> _pageList = [
    const ChildView(desc: 'TabBarView one', hasAppBar: false),
    const ChildView(desc: 'TabBarView two', hasAppBar: false),
    const ChildView(desc: 'TabBarView three', hasAppBar: false),
    const ChildView(desc: 'TabBarView four', hasAppBar: false),
  ];

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    debugPrint('${runtimeType.toString()} initState');
    _tabController = TabController(length: _tabList.length, vsync: this);
  }

  @override
  void dispose() {
    debugPrint('${runtimeType.toString()}  dispose');
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.runtimeType.toString()),
        bottom: TabBar(
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.orange[100],
          indicatorColor: Colors.deepOrange,
          tabs: _tabList,
          controller: _tabController,
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoOverScrollBehavior(),
        // TabBarView 只会初始化当前选中页，后续切换页码时会重新初始化（可以通过子页面结合 AutomaticKeepAliveClientMixin 一起使用来解决每次切换页码时都重新初始化的问题）
        child: TabBarView(
          // physics: const NeverScrollableScrollPhysics(), // 禁用滚动翻页
          controller: _tabController,
          children: _pageList,
        ),
      ),
    );
  }
}
