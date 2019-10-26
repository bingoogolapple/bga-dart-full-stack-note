import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:ui';

void main() => runApp(HybridApp());

class HybridApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hybrid Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBodyWidget());
  }

  _buildBodyWidget() {
    if (window.defaultRouteName == '/') {
      return Container(
        child: Center(
          child: Text('默认路由'),
        ),
      );
    } else {
      final routeMap = jsonDecode(window.defaultRouteName);
      final path = routeMap['path'];
      if (path == 'flutter_create_view') {
        return Container(
          color: Colors.deepPurple,
          child: Center(
            child: Text(routeMap['arguments']),
          ),
        );
      } else if (path == 'flutter_create_fragment') {
        return Container(
          color: Colors.cyanAccent,
          child: Center(
            child: Text(routeMap['arguments']),
          ),
        );
      } else {
        return Container(
          color: Colors.yellow,
          child: Center(
            child: Text('未知路由 $path'),
          ),
        );
      }
    }
  }
}
