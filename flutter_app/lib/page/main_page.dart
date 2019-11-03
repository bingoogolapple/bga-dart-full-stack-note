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
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [HomePage(), CategoryPage(), ShoppingCartPage(), MePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
          if (_currentIndex == index) {
            return;
          }
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
