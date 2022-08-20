import 'package:flutter/material.dart';
import 'package:flutter_app/page/category_page.dart';
import 'package:flutter_app/page/home_page.dart';
import 'package:flutter_app/page/me_page.dart';
import 'package:flutter_app/page/shopping_cart_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _pageList = [
    HomePage(),
    CategoryPage(),
    ShoppingCartPage(),
    MePage()
  ];
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    print('initState => _MainPageState');
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
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

  /// 只会初始化当前选中页，后续切换页码时会重新初始化（可以通过 AutomaticKeepAliveClientMixin 来解决）
  Widget _buildPageViewBody() {
    return ScrollConfiguration(
        behavior: NoOverScrollBehavior(),
        child: PageView(
//          physics: NeverScrollableScrollPhysics(), // 禁用滚动翻页
          children: _pageList,
          controller: _pageController,
          onPageChanged: (index) {
            print('onPageChanged $index');
            _handlePageChanged(index);
          },
        ));
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

class NoOverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    // 去除 Android 滚动到边缘时的水波纹效果，对嵌套在其内部的子控件也生效，除非内部子控件自定义
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    // 去除 iOS 滚动到边缘时出现空白效果，对嵌套在其内部的子控件也生效
    return ClampingScrollPhysics();
  }
}
