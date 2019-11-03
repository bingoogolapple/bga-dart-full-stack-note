import 'package:flutter/material.dart';
import 'package:flutter_app/init/app_init_manager.dart';
import 'package:flutter_app/page/main_page.dart';

void main() {
  AppInitManager.instance.init();
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: MainPage(),
    );
  }
}
