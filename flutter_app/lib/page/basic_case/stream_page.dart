import 'dart:async';

import 'package:flutter/material.dart';

class StreamPage extends StatefulWidget {
  const StreamPage({super.key});

  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  late StreamController<String> _streamController;
  late StreamSubscription<String> _streamSubscription;
  late StreamSink<String> _streamSink;
  String _data = '';

  @override
  void initState() {
    super.initState();
    _testSuccessAndError();

    _streamController = StreamController.broadcast();
    _streamSink = _streamController.sink;
    _streamSubscription = _streamController.stream.listen(
      (event) {
        debugPrint('listen1 onData $event');
        setState(() {
          _data = event;
        });
      },
      onError: (e) {
        debugPrint('listen1 onError $e');
      },
      onDone: () {
        debugPrint('listen1 onDone');
      },
    );
    _streamController.stream.listen(
      (event) {
        debugPrint('listen2 onData $event');
      },
      onError: (e) {
        debugPrint('listen2 onError $e');
      },
      onDone: () {
        debugPrint('listen2 onDone');
      },
    );
  }

  @override
  void dispose() {
    _streamController.close();
    _streamSubscription.cancel();
    super.dispose();
  }

  _testSuccessAndError() {
    // empty 只会发送 onDone 事件，不会发送 onData 和 onError 事件
    const Stream.empty().listen(
      (event) {
        debugPrint('empty onData $event');
      },
      onError: (e) {
        debugPrint('empty onError $e');
      },
      onDone: () {
        debugPrint('empty onDone');
      },
    );
    // empty 只会发送 onError 和 onDone 事件，不会发送 onData 事件
    Stream.error('我是错误消息').listen(
      (event) {
        debugPrint('error onData $event');
      },
      onError: (e) {
        debugPrint('error onError $e');
      },
      onDone: () {
        debugPrint('error onDone');
      },
    );
    // empty 只会发送 onData 和 onDone 事件，不会发送 onError 事件
    Stream.value('我是成功消息').listen(
      (event) {
        debugPrint('value onData $event');
      },
      onError: (e) {
        debugPrint('value onError $e');
      },
      onDone: () {
        debugPrint('value onDone');
      },
    );
    Stream<String> successStream = Stream.fromFuture(fetchDataSuccess());
    successStream.listen(
      (event) {
        debugPrint('successStream onData $event');
      },
      onError: (e) {
        debugPrint('successStream onError $e');
      },
      onDone: () {
        debugPrint('successStream onDone');
      },
    );

    Stream<String> errorStream = Stream.fromFuture(fetchDataError());
    errorStream.listen(
      (event) {
        debugPrint('errorStream onData $event');
      },
      onError: (e) {
        debugPrint('errorStream onError $e');
      },
      onDone: () {
        debugPrint('errorStream onDone');
      },
    );
  }

  Future<String> fetchDataSuccess() async {
    await Future.delayed(const Duration(seconds: 3));
    return '我是成功消息';
  }

  Future<String> fetchDataError() async {
    await Future.delayed(const Duration(seconds: 3));
    throw '我是错误消息';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Text('_data：$_data'),
          StreamBuilder<String>(
            stream: _streamController.stream,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return Text(
                  'connectionState：${snapshot.connectionState} data：${snapshot.data} error：${snapshot.error} stackTrace：${snapshot.stackTrace}');
            },
          ),
          ElevatedButton(
            onPressed: () async {
              await Future.delayed(const Duration(seconds: 3));
              _streamSink.add('sink成功消息');
            },
            child: const Text('Sink addData'),
          ),
          ElevatedButton(
            onPressed: () async {
              await Future.delayed(const Duration(seconds: 3));
              _streamSink.addError('sink错误消息');
              _streamController.close();
            },
            child: const Text('Sink addError'),
          ),
          ElevatedButton(
            onPressed: () async {
              await Future.delayed(const Duration(seconds: 3));
              _streamController.add('controller成功消息');
            },
            child: const Text('Controller addData'),
          ),
          ElevatedButton(
            onPressed: () async {
              await Future.delayed(const Duration(seconds: 3));
              _streamController.addError('controller错误消息');
            },
            child: const Text('Controller addError'),
          ),
          ElevatedButton(
            onPressed: () {
              _streamSubscription.pause();
            },
            child: const Text('Subscription pause'),
          ),
          ElevatedButton(
            onPressed: () {
              // pause 后，发送了消息，然后再 resume 的话还是可以收到 pause 后 resume 前发送的消息
              _streamSubscription.resume();
            },
            child: const Text('Subscription resume'),
          ),
          ElevatedButton(
            onPressed: () {
              _streamSubscription.cancel();
            },
            child: const Text('Subscription cancel'),
          ),
        ],
      ),
    );
  }
}
