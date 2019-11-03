import 'package:flutter/material.dart';

class AppInitManager {
  // 私有构造函数
  AppInitManager._();

  // 保存单例
  static AppInitManager _instance = new AppInitManager._();

  // 获取单例
  static AppInitManager get instance => _instance;

  // 工厂构造函数
  factory AppInitManager() => _instance;

  void init() {
    _initErrorPage();
    _initTargetPlatform();
  }

  void _initErrorPage() {
    ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
      print(flutterErrorDetails.toString());
      return Scaffold(
        body: Center(child: Text("flutter_app 开小差了,请重启 App！", style: TextStyle(fontSize: 20))),
      );
    };
  }

  void _initTargetPlatform() {

  }
}
