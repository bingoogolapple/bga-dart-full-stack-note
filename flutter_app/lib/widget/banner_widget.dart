import 'dart:async';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class BannerWidget extends StatefulWidget {
  final List dataList;
  final Color indicatorColor;

  BannerWidget(this.dataList, this.indicatorColor);

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> with TickerProviderStateMixin {
  PageController _pageController;
  TabController _tabController;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _getZeroIndex());
    _tabController = TabController(length: widget.dataList.length, vsync: this);
    _startAutoScroll();
  }

  @override
  void dispose() {
    if (_pageController != null) {
      _pageController.dispose();
    }
    if (_tabController != null) {
      _tabController.dispose();
    }
    _stopAutoScroll();
    super.dispose();
  }

  _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _pageController.nextPage(duration: kTabScrollDuration, curve: Curves.ease);
    });
  }

  _stopAutoScroll() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        print('鼠标按下、手指按下，停止自动轮播');
        _stopAutoScroll();
      },
      onPointerUp: (PointerUpEvent event) {
        print(' 鼠标松开、手指松开，开始自动轮播');
        _startAutoScroll();
      },
      onPointerCancel: (PointerCancelEvent event) {
        print(' 不是由用户触发的，而是系统经过逻辑判断后对某个 Widget 发送取消事件，开始自动轮播');
        _startAutoScroll();
      },
      child: Stack(
        children: [
          PageView.builder(
              itemCount: _getItemCount(),
              controller: _pageController,
              onPageChanged: (index) {
//                print('当前页 $index');
                if (index == 0) {
                  index = _getZeroIndex();
                  print('跳转到 $index 兼容无限轮播');
                  _pageController.jumpToPage(index);
                } else if (index == _getItemCount() - 1) {
                  index = _getZeroIndex() - 1;
                  print('跳转到 $index 兼容无限轮播');
                  _pageController.jumpToPage(index);
                }

                _tabController.animateTo(_convertIndex(index));
              },
              itemBuilder: (context, index) {
                return FadeInImage.memoryNetwork(
                  fit: BoxFit.cover,
                  placeholder: kTransparentImage,
                  image: widget.dataList[_convertIndex(index)],
                );
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: TabPageSelector(
              controller: _tabController,
              color: Colors.transparent,
              selectedColor: widget.indicatorColor,
            ),
          ),
        ],
      ),
    );
  }

  int _convertIndex(int index) {
    return index % widget.dataList.length;
  }

  int _getZeroIndex() {
    return widget.dataList.length;
  }

  int _getItemCount() {
    return widget.dataList.length * 100;
  }
}
