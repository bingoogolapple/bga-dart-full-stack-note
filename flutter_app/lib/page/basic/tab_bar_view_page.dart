import 'package:flutter/material.dart';

class TabBarViewPage extends StatefulWidget {
  const TabBarViewPage({super.key});

  @override
  State<TabBarViewPage> createState() => _TabBarViewPageState();
}

class _TabBarViewPageState extends State<TabBarViewPage>
    with TickerProviderStateMixin {
  static final _tabList = [
    const Tab(
        icon: Icon(Icons.open_in_new), text: 'One'), // child 和 text 只能指定一个
    const Tab(icon: Icon(Icons.looks_two), text: 'Two'),
    const Tab(icon: Icon(Icons.threed_rotation), text: 'Three'),
    const Tab(icon: Icon(Icons.four_k), text: 'Four'),
    const Tab(icon: Icon(Icons.filter_vintage), text: 'Five'),
    const Tab(icon: Icon(Icons.threesixty), text: 'Six'),
    const Tab(icon: Icon(Icons.sentiment_very_dissatisfied), text: 'Seven'),
    const Tab(icon: Icon(Icons.line_weight), text: 'Eight'),
    const Tab(icon: Icon(Icons.not_interested), text: 'Nine'),
    const Tab(icon: Icon(Icons.transit_enterexit), text: 'Ten'),
    const Tab(icon: Icon(Icons.expand_less), text: 'Eleven'),
    const Tab(icon: Icon(Icons.transfer_within_a_station), text: 'Twelve'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    debugPrint('_TabBarViewPageState initState');
    // TabBarView 必须要结合 TabController 或 DefaultTabController 一起使用
    // 需要手动控制当前页码时才用 TabController，否则直接用 DefaultTabController 包裹即可
    _tabController = TabController(length: _tabList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //   length: _tabList.length,
    //   child: _buildScaffold(isIndicator: false, tabController: null),
    // );

    return _buildScaffold(isIndicator: true, tabController: _tabController);
  }

  _buildScaffold({required bool isIndicator, TabController? tabController}) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('购物车'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        bottom: isIndicator
            ? _buildAppBarBottomTabPageSelector(tabController)
            : _buildAppBarBottomTabBar(tabController),
      ),
      body: TabBarView(
        // physics: const NeverScrollableScrollPhysics(), // 禁用滚动翻页
        controller: tabController,
        children:
            _tabList.map((tab) => Center(child: Text(tab.text!))).toList(),
      ),
    );
  }

  _buildAppBarBottomTabPageSelector(TabController? tabController) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48.0),
      child: Container(
        height: 48.0,
        color: Colors.indigo,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: const Icon(Icons.navigate_before,
                  size: 40, color: Colors.white),
              onTap: () => tabController?.animateTo(_tabController.index - 1),
            ),
            TabPageSelector(
              controller: tabController,
              color: Colors.yellow,
              selectedColor: Colors.green,
            ),
            GestureDetector(
              child: const Icon(Icons.navigate_next,
                  size: 40, color: Colors.white),
              onTap: () => tabController?.animateTo(_tabController.index + 1),
            ),
          ],
        ),
      ),
    );
  }

  _buildAppBarBottomTabBar(TabController? tabController) {
    return TabBar(
      controller: tabController,
      isScrollable: true,
      labelColor: Colors.orange,
      unselectedLabelColor: Colors.orangeAccent,
      indicatorColor: Colors.deepOrange,
      tabs: _tabList,
    );
  }
}
