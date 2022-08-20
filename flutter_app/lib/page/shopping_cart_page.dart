import 'package:flutter/material.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  static const _tabList = [
    Tab(icon: const Icon(Icons.open_in_new), text: 'One'), // child 和 text 只能指定一个
    Tab(icon: const Icon(Icons.looks_two), text: 'Two'),
    Tab(icon: const Icon(Icons.threed_rotation), text: 'Three'),
    Tab(icon: const Icon(Icons.four_k), text: 'Four'),
    Tab(icon: const Icon(Icons.filter_vintage), text: 'Five'),
    Tab(icon: const Icon(Icons.threesixty), text: 'Six'),
    Tab(icon: const Icon(Icons.sentiment_very_dissatisfied), text: 'Seven'),
    Tab(icon: const Icon(Icons.line_weight), text: 'Eight'),
    Tab(icon: const Icon(Icons.not_interested), text: 'Nine'),
    Tab(icon: const Icon(Icons.transit_enterexit), text: 'Ten'),
    Tab(icon: const Icon(Icons.expand_less), text: 'Eleven'),
    Tab(icon: const Icon(Icons.transfer_within_a_station), text: 'Twelve'),
  ];

  late TabController _tabController;

  @override
  bool get wantKeepAlive {
    print('wantKeepAlive _ShoppingCartPageState');
    return true;
  }

  @override
  void initState() {
    super.initState();
    print('initState => _ShoppingCartPageState');
    // 需要手动控制当前页码时才用 TabController，否则直接用 DefaultTabController
    _tabController = TabController(length: _tabList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: _tabList.length,
      child: _buildScaffold(false),
    );

//    return _buildScallfold(true);
  }

  _buildScaffold(bool indicator) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        bottom: indicator ? _buildAppBarBottomTabPageSelector() : _buildAppBarBottomTabBar(),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabList.map((tab) => Center(child: Text(tab.text!))).toList(),
      ),
    );
  }

  _buildAppBarBottomTabPageSelector() {
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
              child: Icon(Icons.navigate_before, size: 40, color: Colors.white),
              onTap: () => _tabController.animateTo(_tabController.index - 1),
            ),
            TabPageSelector(
              controller: _tabController,
              color: Colors.yellow,
              selectedColor: Colors.green,
            ),
            GestureDetector(
              child: Icon(Icons.navigate_next, size: 40, color: Colors.white),
              onTap: () => _tabController.animateTo(_tabController.index + 1),
            ),
          ],
        ),
      ),
    );
  }

  _buildAppBarBottomTabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: Colors.orange,
      unselectedLabelColor: Colors.orangeAccent,
      indicatorColor: Colors.deepOrange,
      tabs: _tabList,
    );
  }
}
