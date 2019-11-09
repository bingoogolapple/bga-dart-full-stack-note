import 'package:flutter/material.dart';
import 'package:flutter_app/page/category_page.dart';
import 'package:flutter_app/page/home_page.dart';
import 'package:flutter_app/page/me_page.dart';
import 'package:flutter_app/page/shopping_cart_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  List<Widget> _pageList = [HomePage(), CategoryPage(), ShoppingCartPage(), MePage()];
  int _currentIndex = 0;
  PageController _pageController;

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
          title: Text('首页'),
          backgroundColor: Colors.deepPurple,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.category),
          title: Text('分类'),
          backgroundColor: Colors.teal,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.shopping_cart),
          title: Text('购物车'),
          backgroundColor: Colors.indigo,
        ),
        BottomNavigationBarItem(
          activeIcon: const Icon(Icons.person),
          icon: const Icon(Icons.person_outline),
          title: Text('我的'),
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

        // 结合 PageView 使用时不用再调用 _handlePageChanged，由 animateToPage => PageView.onPageChanged => _handlePageChanged
        _pageController.animateToPage(index, duration: kTabScrollDuration, curve: Curves.ease);

//        _tabController.animateTo(index);
      },
    );
  }

  /// 打开主界面时所有子 Page 都会被初始化一遍，后续切换页码时不会再重新初始化
  Widget _buildIndexedStackBody() {
    return IndexedStack(
      index: _currentIndex,
      children: _pageList,
    );
  }

  /// 只会初始化当前选中页，后续切换页码时会重新初始化
  Widget _buildPageViewBody() {
    return ScrollConfiguration(
        behavior: NoScrollRippleBehavior(),
        child: PageView(
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

/// 去除滚动到边缘时的水波纹效果
class NoScrollRippleBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
