import 'package:flutter/material.dart';
import 'package:flutter_app/page/category_page.dart';
import 'package:flutter_app/page/home_page.dart';
import 'package:flutter_app/page/me_page.dart';
import 'package:flutter_app/page/shopping_cart_page.dart';

class MainPageBackup extends StatefulWidget {
  @override
  _MainPageBackupState createState() => _MainPageBackupState();
}

class _MainPageBackupState extends State<MainPageBackup>
    with TickerProviderStateMixin {
  List<Widget> _pageList = [
    HomePage(),
    CategoryPage(),
    ShoppingCartPage(),
    MePage()
  ];
  int _currentIndex = 0;
  late PageController _pageController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    print('initState => _MainPageState');
    _pageController = PageController(initialPage: _currentIndex);

    _tabController =
        TabController(initialIndex: 0, length: _pageList.length, vsync: this)
          ..addListener(() {
            setState(() {
              _currentIndex = _tabController.index;
            });
          });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageViewBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: '首页',
          backgroundColor: Colors.deepPurple,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.category),
          label: '分类',
          backgroundColor: Colors.teal,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.shopping_cart),
          label: '购物车',
          backgroundColor: Colors.indigo,
        ),
        BottomNavigationBarItem(
          activeIcon: const Icon(Icons.person),
          icon: const Icon(Icons.person_outline),
          label: '我的',
          backgroundColor: Colors.deepOrange,
        )
      ],
      currentIndex: _currentIndex,
      // 大于3个时默认为 shifting，只有选中的才有文字
      type: BottomNavigationBarType.shifting,
      // 如果没有给 BottomNavigationBarItem 的 title 设置文字颜色，那么文字颜色为这里设置的
      // 如果没有给 BottomNavigationBarItem 的 icon/activeIcon 设置颜色，那么颜色为这里设置的
      // fixedColor: Colors.lightGreen,
      onTap: (int index) {
        // 结合 IndexedStack 使用时调用 _handlePageChanged
//          _handlePageChanged(index);

        // 结合 PageView 使用时不用再调用 _handlePageChanged，由 animateToPage => PageView.onPageChanged => _handlePageChanged，会触发多次 PageView.onPageChanged
//        _pageController.animateToPage(index, duration: kTabScrollDuration, curve: Curves.ease);
        // 只会触发一次 PageView.onPageChanged
        _pageController.jumpToPage(index);

//        _tabController.animateTo(index);
      },
    );
  }

  /// 打开主界面时所有子 Page 都会被初始化一遍，后续切换页码时不会再重新初始化
  // ignore: unused_element
  Widget _buildIndexedStackBody() {
    return IndexedStack(
      index: _currentIndex,
      children: _pageList,
    );
  }

  /// 只会初始化当前选中页，后续切换页码时会重新初始化（可以通过 AutomaticKeepAliveClientMixin 来解决）
  Widget _buildPageViewBody() {
    return PageView(
      children: _pageList,
      controller: _pageController,
      onPageChanged: (index) {
        print('onPageChanged $index');
        _handlePageChanged(index);
      },
    );

    // 可以通过 builder 来做无线轮播
//    return PageView.builder(
//        itemCount: 9223372036854775807,
//        controller: _pageController,
//        onPageChanged: (index) {
//          print('onPageChanged $index');
//          _handlePageChanged(index % _pageList.length);
//        },
//        itemBuilder: (context, index) {
//          return _pageList[index % _pageList.length];
//        });
  }

  /// 只会初始化当前选中页，后续切换页码时会重新初始化
  /// 内部包裹的是 PageView
  /// 只能通过 TabController.addListener 来监听变化，与 BottomNavigationBar 结合使用效果不好
  /// 建议与 TabBar 或 TabPageSelector 结合使用
  // ignore: unused_element
  Widget _buildTabBarViewBody() {
    return TabBarView(
      controller: _tabController,
      children: _pageList,
    );
  }

  _handlePageChanged(int index) {
    if (_currentIndex == index) {
      return;
    }
    print('_handlePageChanged $index');
    setState(() {
      _currentIndex = index;
    });
  }
}
