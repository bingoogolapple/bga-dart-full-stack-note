import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/page/radio_page.dart';
import 'package:flutter_app/widget/banner_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  static const int APPBAR_MAX_SCROLL_OFFSET = 100;
  double _appBarAlpha = 0;

  @override
  bool get wantKeepAlive {
    print('wantKeepAlive _HomePageState');
    return true;
  }

  @override
  void initState() {
    super.initState();
    print('initState => _HomePageState');
  }

  @override
  Widget build(BuildContext context) {
    // 使用 AutomaticKeepAliveClientMixin 保持页面状态时，必须调用 super.build(context)
    super.build(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            toolbarOpacity: _appBarAlpha,
            title: Text('首页'),
            // 要设置成功 0，否则会有一坨阴影
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.deepPurple.withOpacity(_appBarAlpha),
          )),
      body: _buildListView(),
    );
  }

  Widget _buildListView() {
    return MediaQuery.removePadding(
      removeTop: true, // 移除顶部状态栏 padding
      context: context,
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          // 滚动中且为第0个子元素滚动时才处理
          if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
            print('滚动 $scrollNotification');
            _handleOnScroll(scrollNotification.metrics.pixels);
          }
          return false;
        },
        child: ListView(
          children: [
            Container(
              height: 160,
              child: BannerWidget(
                List.generate(4, (index) {
                  return 'http://bgashare.bingoogolapple.cn/banner/imgs/${index + 1}.png';
                }),
                Colors.deepPurple,
              ),
            ),
            MaterialButton(
              color: Colors.yellow,
              child: Text('Radio'),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RadioPage())),
            ),
            Container(height: 150, color: Colors.green[100]),
            Container(height: 150, color: Colors.green[200]),
            Container(height: 150, color: Colors.green[300]),
            Container(height: 150, color: Colors.green[400]),
            Container(height: 150, color: Colors.green[500]),
            Container(height: 150, color: Colors.green[600]),
            Container(height: 150, color: Colors.green[700]),
            Container(height: 150, color: Colors.green[800]),
            Container(height: 150, color: Colors.green[900]),
          ],
        ),
      ),
    );
  }

  void _handleOnScroll(double offset) {
    double alpha = offset / APPBAR_MAX_SCROLL_OFFSET;
    alpha = min(max(alpha, 0), 1);
    setState(() {
      _appBarAlpha = alpha;
    });
  }
}
