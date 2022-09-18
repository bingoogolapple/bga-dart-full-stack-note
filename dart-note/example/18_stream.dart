import 'dart:async';

Stream getStream() {
  StreamController controller = StreamController();
  controller.sink.add(27);
  controller.sink.add("BGA");
  controller.sink.add("bingo");
  controller.sink.add("googol");
  controller.sink.add("apple");
  controller.sink.add("bingoogolapple");
  return controller.stream;
}

testSingleSubscription() {
  Stream stream = getStream();
  // 任意类型的流
  stream
      .where((data) {
        return true;
      })
      .take(5)
      .listen((data) {
        print("testSingleSubscription1 listen $data");
      }, onError: (e) {
        print("testSingleSubscription1 onError $e");
      }, onDone: () {
        print("testSingleSubscription1 onDone");
      }, cancelOnError: false);

  // 单订阅流不能有多个收听者 Bad state: Stream has already been listened to.
//  stream.listen((data) {
//    print("testSingleSubscription2 listen $data");
//  }, onError: (e) {
//    print("testSingleSubscription2 onError $e");
//  }, onDone: () {
//    print("testSingleSubscription2 onDone");
//  }, cancelOnError: false);
}

testBroadcastStream() {
  // BroadcastStream 可以被订阅多次，后订阅的不会收到「已经发送过的」数据，「订阅之前加的且订阅时还未发送过的数据」也能被接收
  Stream stream = getStream().asBroadcastStream();
  stream
      .where((data) {
        return true;
      })
      .take(5)
      .listen((data) {
        print("testBroadcastStream1 listen $data");
      }, onError: (e) {
        print("testBroadcastStream1 onError $e");
      }, onDone: () {
        print("testBroadcastStream1 onDone");
      }, cancelOnError: false);

  scheduleMicrotask(() {
    stream
        .where((data) {
          return true;
        })
        .take(5)
        .listen((data) {
          print("testBroadcastStream2 listen $data");
        }, onError: (e) {
          print("testBroadcastStream2 onError $e");
        }, onDone: () {
          print("testBroadcastStream2 onDone");
        }, cancelOnError: false);
  });
}

testIntStream() {
  // 创建一条处理 int 类型的流
  StreamController<int> numController = StreamController();
  numController.sink.add(27);
  numController.stream.transform(StreamTransformer<int, String>.fromHandlers(handleData: (value, sink) {
    if (value == 27) {
      sink.add("正确");
    } else {
      sink.addError("错误");
    }
  })).listen((data) {
    print("numController listen $data");
  }, onError: (e) {
    print("numController onError $e");
  }, onDone: () {
    print("numController onDone");
  }, cancelOnError: false);
}

main() {
//  testSingleSubscription();
  testBroadcastStream();
//  testIntStream();
}
