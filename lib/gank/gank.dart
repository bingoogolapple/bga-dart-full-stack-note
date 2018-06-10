import 'package:flutter/material.dart';
import 'constant.dart';
import 'daily_page.dart';
import 'category_page.dart';
import 'writing_page.dart';
import 'search_page.dart';

class GankApp extends StatefulWidget {
  @override
  createState() => _GankAppState();
}

class _GankAppState extends State<GankApp> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new IndexedStack(
        children: [
          DailyPage(onClickSearch: _onClickSearch),
          CategoryPage(),
          WritingPage(),
          SearchPage(),
        ],
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), title: Text(DailyPage.title), backgroundColor: DailyPage.color),
          BottomNavigationBarItem(icon: Icon(Icons.category), title: Text(CategoryPage.title), backgroundColor: CategoryPage.color),
          BottomNavigationBarItem(icon: Icon(Icons.content_paste), title: Text(WritingPage.title), backgroundColor: WritingPage.color),
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Text(SearchPage.title), backgroundColor: SearchPage.color)
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  _onClickSearch() {
    setState(() {
      _currentIndex = 3;
    });
  }
}
