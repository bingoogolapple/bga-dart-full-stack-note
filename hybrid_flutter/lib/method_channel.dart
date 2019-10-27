import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelDemo extends StatefulWidget {
  @override
  _MethodChannelDemoState createState() => _MethodChannelDemoState();
}

class _MethodChannelDemoState extends State<MethodChannelDemo> {
  MethodChannel _methodChannel;
  StringBuffer _contentSb = StringBuffer();

  @override
  void initState() {
    super.initState();
    _initMethodChannel();
  }

  void _initMethodChannel() {
    _methodChannel = MethodChannel('MethodChannelPlugin')
      ..setMethodCallHandler((methodCall) {
        _contentSb.writeln('----------\nFlutter 收到 Native 调用：${methodCall.method}');
        if (methodCall.method == 'nativeInvokeFlutterWithoutResult') {
          setState(() {
            _contentSb.writeln('${methodCall.method} | ${methodCall.arguments}');
          });
          return null;
        } else if (methodCall.method == 'nativeInvokeFlutterWithResult') {
          // 给 Native 端的返回值
          setState(() {
            _contentSb.writeln('${methodCall.method} | ${methodCall.arguments}');
          });
          if (Random().nextBool()) {
            return Future.value('Flutter 收到了 nativeInvokeFlutterWithResult：成功');
          } else {
            return Future.error('Flutter 收到了 nativeInvokeFlutterWithResult：失败');
          }
        } else {
          return null;
        }
      });
  }

  void _flutterInvokeNativeWithoutResult() {
//    _methodChannel.invokeListMethod
//    _methodChannel.invokeListMethod
    _methodChannel.invokeMethod('flutterInvokeNativeWithoutResult', 'red').then((result) {
      setState(() {
        _contentSb.writeln('flutterInvokeNativeWithResult 成功：$result');
      });
    }).catchError((error) {
      setState(() {
        _contentSb.writeln('flutterInvokeNativeWithResult 失败：$error');
      });
    });
  }

  void _flutterInvokeNativeWithResult() {
    _methodChannel.invokeMethod('flutterInvokeNativeWithResult', 100).then((result) {
      setState(() {
        _contentSb.writeln('flutterInvokeNativeWithResult 收到返回结果：$result');
      });
    }).catchError((error) {
      setState(() {
        _contentSb.writeln('flutterInvokeNativeWithResult 失败：$error');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MaterialButton(
            child: Text('flutterInvokeNativeWithoutResult'),
            onPressed: _flutterInvokeNativeWithoutResult,
          ),
          MaterialButton(
            child: Text('flutterInvokeNativeWithResult'),
            onPressed: _flutterInvokeNativeWithResult,
          ),
          SingleChildScrollView(
            child: Container(child: Text(_contentSb.toString())),
          ),
        ],
      ),
    );
  }
}
