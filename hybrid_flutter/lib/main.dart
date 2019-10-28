import 'package:flutter/material.dart';
import 'package:hybrid_flutter/basic_message_channel.dart';
import 'dart:convert';
import 'dart:ui';

import 'package:hybrid_flutter/event_channel.dart';
import 'package:hybrid_flutter/method_channel.dart';

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
      } else if (path == 'flutter_create_controller_without_engine') {
        return Container(
          color: Colors.orange,
          child: Center(
            child: Text(routeMap['arguments']),
          ),
        );
      } else if (path == 'flutter_create_controller_with_engine') {
        return Container(
          color: Colors.deepPurple,
          child: Center(
            child: Text(routeMap['arguments']),
          ),
        );
      } else if (path == 'event_channel_demo') {
        return EventChannelDemo();
      } else if (path == 'method_channel_demo') {
        return MethodChannelDemo();
      } else if (path == 'basic_message_channel_demo') {
        return BasicMessageChannelDemo();
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
