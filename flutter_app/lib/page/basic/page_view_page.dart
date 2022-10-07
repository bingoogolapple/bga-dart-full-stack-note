import 'package:flutter/material.dart';
import 'package:flutter_app/mock/net_images.dart';
import 'package:flutter_app/utils/no_over_scroll_behavior.dart';

class PageViewPage extends StatefulWidget {
  const PageViewPage({Key? key}) : super(key: key);

  @override
  State<PageViewPage> createState() => _PageViewBuilderPageState();
}

class _PageViewBuilderPageState extends State<PageViewPage> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageView'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: PageView.builder(
        controller: _pageController, // controller 是可选参数，当需要手动控制页码时才使用
        onPageChanged: (currentPage) {
          debugPrint('currentPage: $currentPage');
        },
        itemCount: netImages.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            netImages[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}

// ignore: unused_element
class _PageViewPageState extends State<PageViewPage> {
  final PageController _pageController = PageController(
    // initialPage: 1, // 默认选中所有为 1 的页面
    // keepPage: false, // 不记录当前选中页面索引，默认为 true 记录当前页面索引
    viewportFraction: 0.85, // 设置页面视图只展示 85%
  );
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageView'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: ScrollConfiguration(
        behavior: NoOverScrollBehavior(),
        child: PageView(
          // pageSnapping: false, // 禁止回弹或翻页
          // reverse: true, // 反着排序，原本的第一页放到之后，并且默认选中最后一页
          // scrollDirection: Axis.vertical, // 默认是水平方向滚动，改为垂直方向滚动
          controller: _pageController, // controller 是可选参数
          onPageChanged: (currentPage) {
            debugPrint('currentPage: $currentPage');
          },
          children: [
            Container(
              color: Colors.red,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_pageController.hasClients) {
                          _pageController.jumpToPage(1);
                        }
                      },
                      child: const Text('One Next jumpToPage'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_pageController.hasClients) {
                          _pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: const Text('One Next animateToPage'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_pageController.hasClients) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: const Text('One Next nextPage'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              // 给 Container 设置 Alignment.center 也能能少嵌套一层 Center 组件
              alignment: Alignment.center,
              color: Colors.green,
              child: const Text('Two', style: TextStyle(color: Colors.white)),
            ),
            Container(
              // 给 Container 设置 Alignment.center 也能能少嵌套一层 Center 组件
              alignment: Alignment.center,
              color: Colors.blue,
              child: const Text('Three', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
