import 'package:flutter/material.dart';
import 'package:flutter_app/page/demo/home_page/child_view.dart';
import 'package:flutter_app/utils/no_over_scroll_behavior.dart';

class BottomNavigationBarAndPageView extends StatefulWidget {
  const BottomNavigationBarAndPageView({super.key});

  @override
  State<BottomNavigationBarAndPageView> createState() =>
      _BottomNavigationBarAndPageViewState();
}

class _BottomNavigationBarAndPageViewState
    extends State<BottomNavigationBarAndPageView>
    with TickerProviderStateMixin {
  static final List<Widget> _pageList = [
    const ChildView(desc: 'PageView one', hasAppBar: true),
    const ChildView(desc: 'PageView two', hasAppBar: true),
    const ChildView(desc: 'PageView three', hasAppBar: true),
    const ChildView(desc: 'PageView four', hasAppBar: true),
  ];
  static final _bottomNavigationBarItemList = [
    const BottomNavigationBarItem(
      // 必选，条目标题
      label: 'One',
      // 必选，未选中时的条目图标
      icon: Icon(
        Icons.one_k,
        color: Colors.yellow,
      ),
      // 可选，已选中时的条目图标
      activeIcon: Icon(
        Icons.one_k_outlined,
        color: Colors.purple,
      ),
      // 可选，默认为 label 的值
      tooltip: '',
      // 可选，item 被选中时整个 BottomNavigationBar 的背景色，仅在 type 为 shifting 时才会生效
      backgroundColor: Colors.deepPurple,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.two_k),
      label: 'Two',
      backgroundColor: Colors.teal,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.three_k),
      label: 'Three',
      backgroundColor: Colors.indigo,
    ),
    const BottomNavigationBarItem(
      activeIcon: Icon(Icons.four_k),
      icon: Icon(Icons.person_outline),
      label: 'Four',
      backgroundColor: Colors.lime,
    )
  ];

  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    debugPrint('${runtimeType.toString()} initState');
    _pageController = PageController();
  }

  @override
  void dispose() {
    debugPrint('${runtimeType.toString()}  dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: NoOverScrollBehavior(),
        // PageView 只会初始化当前选中页，后续切换页码时会重新初始化（可以通过子页面结合 AutomaticKeepAliveClientMixin 一起使用来解决每次切换页码时都重新初始化的问题）
        child: PageView(
          // physics: const NeverScrollableScrollPhysics(), // 禁用滚动翻页
          controller: _pageController,
          onPageChanged: (index) {
            debugPrint(
                '${runtimeType.toString()} PageView onPageChanged $index');
            setState(() {
              _currentIndex = index;
            });
          },
          children: _pageList,
        ),

        // child: PageView.builder(
        //   controller: _pageController,
        //   itemCount: _pageList.length,
        //   onPageChanged: (index) {
        //     debugPrint(
        //         '${runtimeType.toString()} PageView onPageChanged $index');
        //     setState(() {
        //     _currentIndex = index;
        //   });
        //   },
        //   itemBuilder: (context, index) {
        //     return _pageList[index];
        //   },
        // ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // 必选，items 的长度至少为 2
        items: _bottomNavigationBarItemList,
        // 必选，当前选中的条目索引
        currentIndex: _currentIndex,
        // 必选，条目点击事件
        onTap: (index) {
          debugPrint(
              '${runtimeType.toString()} BottomNavigationBar onTap $index');
          // 结合 PageView 使用时不用再单独修改 _currentIndex，通过 jumpToPage 触发 PageView.onPageChanged 时再修改 _currentIndex
          _pageController.jumpToPage(index);
        },
        // items 长度为 2 或 3 时默认为 fixed（不管有没有选中都会展示文字），items 长度大于等于 4 时默认为 shifting（未选中时只展示图标，只有选中的才会展示文字）
        type: BottomNavigationBarType.shifting,
        // 可选，整个 BottomNavigationBar 的背景色，默认为白色。仅在 type 为 fixed 时才会生效，type 为 shifting 时该值不会生效，需要通过给 BottomNavigationBarItem 指定 backgroundColor 来设置整个 BottomNavigationBar 的背景色
        backgroundColor: Colors.amber,
        // 可选，条目选中时 BottomNavigationBarItem 的 title、icon 颜色（未单独在 BottomNavigationBarItem 中设置 icon 颜色的情况下）
        selectedItemColor: Colors.red,
        // 可选，条目未选中时 BottomNavigationBarItem 的 title、activeIcon 颜色（未单独在 BottomNavigationBarItem 中设置 activeIcon 颜色的情况下）
        unselectedItemColor: Colors.green,
        // 可选，是否展示已选中条目的文本，默认为 true
        showSelectedLabels: true,
        // 可选，是否展示未选中条目的文本，type 为 fixed 时默认为 true，type 为 shifting 时默认为 false
        showUnselectedLabels: false,
        // 可选，选中条目的文本大小，默认值 14
        selectedFontSize: 14,
        // 可选，未选中条目的文本大小，默认值 12
        unselectedFontSize: 12,
        // 可选，图标大小，默认值 24
        iconSize: 24,
        // 可选，顶部阴影，默认值 8
        elevation: 8,
      ),
    );
  }
}
