import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_app/mock/net_images.dart';
import 'package:flutter_app/widget/banner_widget.dart';

class NotificationListenerPage extends StatefulWidget {
  const NotificationListenerPage({super.key});

  @override
  State<NotificationListenerPage> createState() =>
      _NotificationListenerPageState();
}

class _NotificationListenerPageState extends State<NotificationListenerPage> {
  static const int appBarMaxScrollOffset = 100;
  double _appBarAlpha = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 扩展 body 到 AppBar 底部
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          // 要设置成功 0，否则会有一整块阴影
          elevation: 0,
          toolbarOpacity: _appBarAlpha,
          backgroundColor: Colors.deepOrange.withOpacity(_appBarAlpha),
          title: Text(widget.runtimeType.toString().replaceAll('Page', '')),
          centerTitle: true,
        ),
      ),
      body: MediaQuery.removePadding(
        // 移除顶部状态栏 padding
        removeTop: true,
        context: context,
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            // ScrollNotification 有 UserScrollNotification、ScrollStartNotification、ScrollUpdateNotification、ScrollEndNotification
            // 滚动中（scrollNotification 为 ScrollUpdateNotification）且为第 0 个子元素（scrollNotification.depth 为 0）滚动时才处理
            if (scrollNotification is ScrollUpdateNotification &&
                scrollNotification.depth == 0) {
              double offset = scrollNotification.metrics.pixels;
              // debugPrint('滚动 $offset');
              double alpha = offset / appBarMaxScrollOffset;
              alpha = min(max(alpha, 0), 1);
              setState(() {
                _appBarAlpha = alpha;
              });
            }
            return false;
          },
          child: _buildListView(),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView(
      children: [
        SizedBox(
          height: 160,
          child: BannerWidget(
            List.generate(4, (index) {
              return netImages[index];
            }),
            Colors.deepPurple,
          ),
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
    );
  }
}
