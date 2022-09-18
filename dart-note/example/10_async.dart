import 'dart:async';

// 返回一个延迟 2 秒后正常执行的 Future
Future<String> successFuture(String msg) {
//  return Future<String>(() {
//    return "demo1";
//  });

  return Future<String>.delayed(Duration(milliseconds: 2000), () {
    return '$msg 调用的 successFuture';
  });
}

// 返回一个延迟 2 秒后会抛异常的 Future
Future<String> errorFuture(String msg) {
  return Future<String>.delayed(Duration(milliseconds: 2000), () {
    throw Exception('$msg 调用的 errorFuture Exception');
  });
}

// 使用 then、catchError 方式执行 Future
testFuture() {
  successFuture('testFuture').then((value) {
    print(value);
    return value + "对数据做一次加工";
  }).then((value) {
    print(value);
  }).catchError((error) {
    print('testFuture successFuture catchError');
  }).whenComplete(() { // 不管成功还是失败都会调用 whenComplete
    print('testFuture successFuture whenComplete');
  });
  print('testFuture 调用了 successFuture');

  errorFuture('testFuture').then((value) {
    print(value);
  }).catchError((error) {
    print('testFuture errorFuture catchError $error');
  }).whenComplete(() { // 不管成功还是失败都会调用 whenComplete
    print('testFuture errorFuture whenComplete');
  });
  print('testFuture 调用了 errorFuture');
}

// 使用 async、await 方式执行 Future，官方推荐使用这种方式。要使用 await，方法必须是 async 的
testFutureAsyncAwait() async {
  try {
    String result = await successFuture('testFutureAsyncAwait');
    print(result);
  } catch (e) {
    print('testFutureAsyncAwait successFuture catchError $e');
  }
  print('testFutureAsyncAwait 调用了 successFuture');

  try {
    String result = await errorFuture('testFutureAsyncAwait');
    print(result);
  } catch (e) {
    print('testFutureAsyncAwait errorFuture catchError $e');
  }
  print('testFutureAsyncAwait 调用了 errorFuture');
}

testNotAsync() {
  testFuture();
  print('testNotAsync 调用了 testFuture');
  testFutureAsyncAwait();
  print('testNotAsync 调用了 testFutureAsyncAwait');
}

testAsync() async {
  testFuture();
  print('testAsync 调用了 testFuture');
  await testFutureAsyncAwait();
  print('testAsync 调用了 testFutureAsyncAwait');
}

testMicrotask() {
  // Microtask 是在 Event Queue 中的某一个 Event 处理完后才会执行，而不是在执行 Event 期间插进去执行的
  scheduleMicrotask(() {
    print('microtask1');
  });
  print('testMicrotask');
  StringBuffer stringBuffer = StringBuffer();
  for (int i = 0; i < 100; i++) {
    stringBuffer.write(i);
  }
  print(stringBuffer.toString());

  scheduleMicrotask(() {
    print('microtask2');
  });

  stringBuffer = StringBuffer();
  for (int i = 0; i < 50; i++) {
    stringBuffer.write(i);
  }
  print(stringBuffer.toString());
//  testMicrotask
//  0123456.........
//  0123456.........
//  main
//  microtask1
//  microtask2
}

main() {
//  testAsync();
//  testNotAsync();
  testMicrotask();
  print('main');
}
