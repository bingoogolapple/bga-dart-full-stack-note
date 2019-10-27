import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasicMessageChannelDemo extends StatefulWidget {
  @override
  _BasicMessageChannelDemoState createState() => _BasicMessageChannelDemoState();
}

class _BasicMessageChannelDemoState extends State<BasicMessageChannelDemo> {
  BasicMessageChannel _channel;
  StringBuffer _contentSb = StringBuffer();

  @override
  void initState() {
    super.initState();
    _initMethodChannel();
  }

  void _initMethodChannel() {
    _channel = BasicMessageChannel('BasicMessageChannelPlugin', StringCodec());
    _channel.setMessageHandler((message) {
      print('Flutter 收到消息 $message');
      setState(() {
        _contentSb.writeln('Flutter 收到消息 $message');
      });
      if (message != null && message.contains('with result')) {
        return Future.value('Flutter 收到消息 $message 后回复');
      } else {
        return null;
      }
    });
  }

  void _flutterSendMessageWithoutResult() {
    _channel.send('Flutter 发送消息，without result');
  }

  void _flutterSendMessageWithResult() {
    _channel.send('Flutter 发送消息，with result').then((result) {
      setState(() {
        _contentSb.writeln('Flutter 收到结果：$result');
      });
    }).catchError((error) {
      setState(() {
        _contentSb.writeln('Flutter 发送消息失败：$error');
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
            child: Text('flutterSendMessageWithoutResult'),
            onPressed: _flutterSendMessageWithoutResult,
          ),
          MaterialButton(
            child: Text('flutterSendMessageWithResult'),
            onPressed: _flutterSendMessageWithResult,
          ),
          SingleChildScrollView(
            child: Container(child: Text(_contentSb.toString())),
          ),
        ],
      ),
    );
  }
}
