import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventChannelDemo extends StatefulWidget {
  @override
  _EventChannelDemoState createState() => _EventChannelDemoState();
}

class _EventChannelDemoState extends State<EventChannelDemo> {
  StreamSubscription _streamSubscription;
  StringBuffer _contentSb = StringBuffer();

  void _subscribe() {
    // 对应 Android 端 onCancel 和 onListen 方法的第一个参数，可不传值
    final arguments = ['aaaaa', 1111];
    _streamSubscription = EventChannel("EventChannelPlugin").receiveBroadcastStream(arguments).listen(_onToDart, onError: _onToDartError, onDone: _onDone);
  }

  void _cancelSubscribe() {
    _streamSubscription.cancel();
    _streamSubscription = null;
  }

  void _onToDart(event) {
    setState(() {
      _contentSb.writeln('_onToDart：$event');
    });
  }

  _onToDartError(error) {
    setState(() {
      PlatformException exception = error;

      _contentSb.writeln('_onToDartError：${exception?.code} | ${exception?.message} | ${exception?.details}');
    });
  }

  void _onDone() {
    setState(() {
      _contentSb.writeln('_onDone');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MaterialButton(
            child: Text('订阅 Native 消息'),
            onPressed: _subscribe,
          ),
          MaterialButton(
            child: Text('取消订阅 Native 消息'),
            onPressed: _cancelSubscribe,
          ),
          SingleChildScrollView(
            child: Text(_contentSb.toString()),
          ),
        ],
      ),
    );
  }
}
