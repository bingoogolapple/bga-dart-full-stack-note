import 'package:decimal/decimal.dart';

main() {
  // 数值类型：int 和 double 都继承自 num
  num a = 1;
  print(a);
  print(a.runtimeType); // int
  a = 3.14;
  print(a);
  print(a.runtimeType); // double
  a = 1;
  print(a.runtimeType); // int

  int b = 1;
  // double 类型的值不能赋值给 int 类型的变量 Error: A value of type 'dart.core::double' can't be assigned to a variable of type 'dart.core::int'
//  b = 3.14;

  double c = 3.14;
  print(c.runtimeType); // double
  // int 类型的值可以赋值给 double 类型的变量
  c = 1;
  print(c.runtimeType); // double

  double d = 6.28;
  int e = 2;
  print(d + e); // 加 8.280000000000001
  // 使用第三方库 https://pub.flutter-io.cn/packages/decimal
  print(Decimal.parse(d.toString()) + Decimal.fromInt(e)); // 加 8.28
  print(d - e); // 减 4.28
  print(d * e); // 乘 12.56
  print(d / e); // 除 3.14
  print(d ~/ e); // 取整 3
  print(d % e); // 取余 0.28000000000000025
  print(Decimal.parse(d.toString()) % Decimal.fromInt(e)); // 取余 0.28

  var f = 0.0 / 0.0;
  print(f); // 非数字 NaN
  print(f.runtimeType); // double
  var g = 0 / 0;
  print(g); // 非数字 NaN
  print(g.runtimeType); // double
  print(0.1 / 0); // Infinity
  print(-0.1 / 0); // -Infinity

  print(1.isOdd); // 奇数 true
  print(1.isEven); // 偶数 false
  print(2.isOdd); // 奇数 false
  print(2.isEven); // 偶数 true
  print((-100).abs()); // 取绝对值 100
  print(1.4.round()); // 四舍五入 1
  print(1.5.round()); // 四舍五入 2
  print(1.5.floor()); // 取小于它的最大整数 1
  print(1.5.ceil()); // 取大于它的最小整数 2
  print(1.5.toInt()); // double 转换成 int 1
  print(1.toDouble()); // int 转换成 double 1.0
  print(3.1415926.toStringAsFixed(2)); // 保留「2」位小数 3.14
  print(3.1415926.toStringAsPrecision(3)); // 保留「3」位小数后精确结果的字符串 3.14
  print(3.1415926.roundToDouble()); // 四舍五入的双精度值 3.0
  print(3.1415926.floorToDouble()); // 取小于它的最大双精度值 3.0
  print(3.1415926.ceilToDouble()); // 取大于它的最大双精度值 4.0
}
