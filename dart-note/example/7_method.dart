// dart 文件后面直接跟参数，多个参数用空格隔开 dart example/7_method.dart 1 2 "sdfs"
void main(List<String> args) {
  print(args);
  print(args.runtimeType);

  print(test1());
  print(test2(2, 3));
  print(test3(2, 3));
  print(test4(2, 3));
  print('test5 ${test5(2, 3)}');
  print('test6 ${test6(2, 3)}');

  // 可选参数
  testNamedParam(1);
  testNamedParam(1, p2: 2);
  testNamedParam(1, p3: 3);
  testNamedParam(1, p3: 3, p2: 2);
  testNamedParamDefault(1);
  testDefaultListMapParam();
  testPositionParam(1);
  testPositionParam(1, 2);
  testPositionParam(1, 2, 3);
  testPositionParamDefault(1);

  // 方法对象
  var func1 = testNamedParam;
  print(func1); // Closure: (dynamic, {dynamic p2, dynamic p3}) => dynamic from Function 'testNamedParam': static.
  func1(1);
  Function func2 = testPositionParam;
  print(func2); // Closure: (dynamic, [dynamic, dynamic]) => dynamic from Function 'testPositionParam': static.
  func2(2);

  // 匿名方法
  func3(p1, {p2, p3}) {
    print('func3 p1 = $p1, p2 = $p2, p3 = $p3');
  }

  print(func3); // Closure: (dynamic, {dynamic p2, dynamic p3}) => Null
  func3(1);
  func3(1, p2: 2);

  // Dart 官方推荐：要用方法声明的形式来给方法起个名字
  var func4 = (p1, {p2, p3}) {
    print('func4 p1 = $p1, p2 = $p2, p3 = $p3');
  };
  func4 = (p1, {p2, p3}) => print('func4 p1 = $p1, p2 = $p2, p3 = $p3');

  func4(1);
  func4(1, p2: 2);

  ((p1, {p2, p3}) {
    print('匿名 p1 = $p1, p2 = $p2, p3 = $p3');
  })(1, p2: 2);

  ((p1, {p2, p3}) => print('箭头匿名 p1 = $p1, p2 = $p2, p3 = $p3'))(1, p2: 2);

  // 方法参数
  [1, 2, 3, 4].forEach(print);
  print(testFunParam(['p1', 'p2'], times));
  print(testFunParam(['p1', 'p2'], (str) {
    return str * 3;
  }));

  // 闭包
  var func5 = testClosure1();
  func5(1);
  func5(2);
  var func6 = testClosure2();
  func6(1);
  func6(2);
  var func7 = testClosure3();
  func7(1.toDouble());
  print(func7(2.1));

  print(func5.runtimeType); // (dynamic) => Null
  print(func6.runtimeType); // (dynamic) => Null
  print(func7.runtimeType); // (double) => double
}

test1() {
  print('test1');
}

int test2(int p1, int p2) {
  print('test2 $p1 + $p2');
  return p1 + p2;
}

// 参数类型和返回值类型可以省略
test3(p1, p2) {
  print('test3 $p1 + $p2');
  return p1 + p2;
}

// 必须写 return 才会有返回值
test4(p1, p2) {
  print('test4 $p1 + $p2');
  p1 + p2;
}

// 箭头函数
int test5(int p1, int p2) => p1 + p2;

test6(p1, p2) => p1 + p2;

/**
 * 使用花括号定义命名可选参数，必须在最后
 * testNamedParam(1);
 * testNamedParam(1, p2: 2);
 * testNamedParam(1, p3: 3);
 * testNamedParam(1, p3: 3, p2: 2);
 */
testNamedParam(p1, {p2, p3}) {
  print('testNamedParam p1 = $p1, p2 = $p2, p3 = $p3');
}

/**
 * 命名可选参数可以指定默认值
 * testNamedParamDefault(1);
 */
testNamedParamDefault(p1, {p2 = 'p2default', p3 = 'p3default'}) {
  print('testNamedParamDefault p1 = $p1, p2 = $p2, p3 = $p3');
}

/**
 * list 和 map 也可以设置默认值，但必须用 const 修饰为编译期常量
 */
testDefaultListMapParam({List<int> list = const [1, 2, 3], Map<String, String> gifts = const {'first': 'paper', 'second': 'cotton', 'third': 'leather'}}) {
  print('list:  $list');
  print('gifts: $gifts');
}

/**
 * 使用中括号定义位置可选参数，必须在最后
 * testPositionParam(1);
 * testPositionParam(1, 2);
 * testPositionParam(1, 2, 3);
 */
testPositionParam(p1, [p2, p3]) {
  print('testPositionParam p1 = $p1, p2 = $p2, p3 = $p3');
}

/**
 * 位置可选参数可以指定默认值
 * testPositionParamDefault(1);
 */
testPositionParamDefault(p1, [p2 = 'p2default', p3 = 'p3default']) {
  print('testPositionParamDefault p1 = $p1, p2 = $p2, p3 = $p3');
}

// 方法参数
List<String> testFunParam(List<String> list, String action(String str)) {
  for (var i = 0; i < list.length; i++) {
    list[i] = action(list[i]);
  }
  return list;
}

String times(String str) {
  return str * 2;
}

testClosure1() {
  int count = 100;

  printCount(p1) {
    print(count + p1);
  }

  return printCount;
}

testClosure2() {
  int count = 100;

  var func = (p1) {
    print(count + p1);
  };

  return func;
}

testClosure3() {
  int count = 100;

  return (double p1) {
    double result = count + p1.toDouble();
    print(result);
    return result;
  };
}
