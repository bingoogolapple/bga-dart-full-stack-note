main() {
  // 弱类型定义方式：用 var 声明变量时可以动态类型转换（不能赋初始值），用 dynamic 声明时可以赋初始值
  var a;
  // 未初始化时，默认值为 null
  print(a);
  a = 3;
  print(a);
  print(a.runtimeType); // int
  a = 'BGA';
  print(a);
  print(a.runtimeType); // String

  // 强类型定义方式：用具体类型定义变量时，同父类型可以动态转换，和 Java 一样
  num b = 1;
  print(b);
  print(b.runtimeType);
  b = 3.14;
  print(b);
  print(b.runtimeType);
  print("-------");
  // Error: A value of type 'dart.core::String' can't be assigned to a variable of type 'dart.core::int'.
//  b = "BGA";

  int c = 1;
  // Error: A value of type 'double' can't be assigned to a variable of type 'int'.
//  c = 3.14;

  double d = 3.14;
  d = 1;
  print(d.runtimeType); // double
  d = null;
  print(d); // null
  print(d.runtimeType); // Null

  // 使用 final 声明一个只能赋值一次的变量
  final e = 1;
  // Error: Setter not found: 'e'
//  e = 2;
  // 使用 const 声明编译期常量，在编译期就能确定它的值
  const f = 1;
  // Error: Setter not found: 'f'
//  d = f;

  testDefaultValue();
  new TestConstant("Dart").test();
}

class TestConstant {
  // 使用 final 声明只能赋值一次的常量（可以在构造方法中延迟初始化），运行期赋值，支持类型推导
  final a = 1;
  final b;

  TestConstant(String b) : this.b = b {
    print(a.runtimeType); // int
    print(b.runtimeType); // String
  }

  void test() {
    // 使用 const 声明编译期常量，必须在编译期就能确定它的值，支持类型推导
    // 等号右边的 a 为 final 定义运行期常量，编译期并不能确定其值，所以会报错 Error: Not a constant expression
//    const c = a;
    const c = 3;
    print(c.runtimeType); // int
    // 等号右边的 c 为编译期常量，所以也能在编译期确定 d 的值
    const d = c;
  }
}

// 所有的类型，声明后不赋值的话，默认都是 null
testDefaultValue() {
  var a;
  print(a);
  bool b;
  print(b);
  dynamic c;
  print(c);
  num d;
  print(d);
  int e;
  print(e);
  double f;
  print(f);
  print(f.runtimeType); // Null
  String g;
  print(g);
  print(g.runtimeType); // Null
  print('=============');
}
