import 'package:flutter/material.dart';
import 'package:flutter_app/page/demo/home_page/child_view.dart';

class TabBarAndIndexedStack extends StatefulWidget {
  const TabBarAndIndexedStack({super.key});

  @override
  State<TabBarAndIndexedStack> createState() => _TabBarAndIndexedStackState();
}

class _TabBarAndIndexedStackState extends State<TabBarAndIndexedStack>
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
    const ChildView(desc: 'IndexedStack one', hasAppBar: false),
    const ChildView(desc: 'IndexedStack two', hasAppBar: false),
    const ChildView(desc: 'IndexedStack three', hasAppBar: false),
    const ChildView(desc: 'IndexedStack four', hasAppBar: false),
  ];

  late final TabController _tabController;
  int _currentIndex = 0;

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
          onTap: (index) {
            debugPrint('${runtimeType.toString()} TabBar onTap $index');
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      // IndexedStack 会把所有子 Page 都会被初始化一遍，后续切换页码时不会再重新初始化。不管子页面是否结合 AutomaticKeepAliveClientMixin 一起使用效果都是一样的
      body: IndexedStack(
        index: _currentIndex,
        children: _pageList,
      ),
    );
  }
}
