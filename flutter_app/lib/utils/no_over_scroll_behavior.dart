import 'package:flutter/material.dart';

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
    return const ClampingScrollPhysics();
  }
}
