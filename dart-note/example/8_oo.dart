import 'dart:math';

/**
 * Dart 没有表示访问权限的关键字，而是用符号名表示访问权限
 * 另外，Dart 中不存在针对类的访问权限，只有针对包（package）的
 * 凡以「_」（下划线）开头的符号（变量、类、函数等等）都是包内可见的，否则是包内外都可见的
 */
main() {
  // .. 语法为级联调用。使用级联调用语法可以在一个对象上执行多个操作
  var a = ChildPoint.test3(3, 4)
    ..getDistanceFromOrigin().toString()
    ..printX()
    ..printY();

  // as    is    is!
  print(a is Point);

  a
    ..getDistanceFromOrigin().toString()
    ..printX()
    ..printY();

  ImmutablePoint point1 = const ImmutablePoint(0, 0);
  ImmutablePoint point2 = const ImmutablePoint(0, 0);
  print('point1 == point2 is ${point1 == point2}');

  var logger = Logger('BGA');
  logger = Logger('BGA');
  logger.log('BGA');
  logger = Logger.test('bingoogolapple');
  logger = Logger.test('bingoogolapple');
  logger.log('bingoogolapple');

  var rect = new Rectangle(3, 4, 20, 15);
  print('before right is ${rect.right}');
  rect.right++;
  rect.right++;
  print('after right is ${rect.right}');

  testEnum();

  testTypeDef();

  testSingleton();
  testDynamicAndObject();

  testException();
}

// 和 Java 一样通过 class 关键字定义类
class Point {
  // 定义静态变量
  static int a = 1;

  // 定义属性
  int x;
  int y;
  double distance;

  // Dart 中每一个属性默认都有 getter 和 setter 方法，我们也可以自定义属性的 getter 和 setter
//  bool get isFar {
//    return distance > 1000;
//  }

  bool get isFart => distance > 100;

//  Point(x, y)
//      : x = x,
//        y = y,
//        distance = sqrt(x * x + y * y) {
//    // TODO 做其他事情
//  }

  // 上面的简化写法。构造方法中支持「this.属性名」语法糖，传入参数时自动赋值，不用像 Java 那样挨个写 this.xxx = xxxx
//  Point(this.x, this.y) : distance = sqrt(x * x + y * y) {
//    // TODO 做其他事情
//  }

  // 上面的简化写法
  Point(this.x, this.y) : distance = sqrt(x * x + y * y);

  // 命名构造方法：类名后加「.自己的名字」
  Point.named(this.x, this.y, this.distance);

  // 重定向构造方法
  Point.alongXAxis(x) : this(x, 0);

  Point.alongYAxis(y) : this.test1(0, y);

  Point.test1(x, y)
      : x = x,
        y = y,
        distance = sqrt(x * x + y * y);

  Point.test2(this.x, this.y) : distance = sqrt(x * x + y * y);

  Point.test3(this.x, this.y) : distance = sqrt(x * x + y * y) {
    print('Point.test3 x is $x, y is $y, distance is $distance');
  }

  double getDistanceFromOrigin() {
    print("getDistanceFromOrigin");
    return distance;
  }

  void printX() {
    print("printX");
  }

  void printY() {
    print("printY");
  }

  // 通过 operator 关键字重载操作符
  Point operator +(Point other) {
    return new Point(this.x + other.x, this.y + other.y);
  }

  // 定义静态方法
  static num distanceBetween(Point a, Point b) {
    var dx = a.x - b.x;
    var dy = a.y - b.y;
    return sqrt(dx * dx + dy * dy);
  }
}

class ChildPoint extends Point {
  ChildPoint.test3(x, y) : super.test3(x, y) {
    print('ChildPoint.test3 x is $x, y is $y, distance is $distance');
  }
}

/**
 * 如果你的类提供一个状态不变的对象（其实也相当于注解），可以把这些对象定义为编译时常量。
 * 需要定义一个 const 构造方法，并且声明所有类的变量为 final。这在 Flutter 中用的比较多
 *
 * ImmutablePoint point1 = const ImmutablePoint(0, 0);
 * ImmutablePoint point2 = const ImmutablePoint(0, 0);
 * print('point1 == point2 is ${point1 == point2}');
 */
class ImmutablePoint {
  final num x;
  final num y;

  const ImmutablePoint(this.x, this.y);
}

class Logger {
  final String name;
  bool mute = false;

  static final Map<String, Logger> _cache = <String, Logger>{};

  // 如果一个构造方法并不总是返回一个新的对象，则使用 factory 来定义这个构造方法
  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      print('旧的$name');
      return _cache[name];
    } else {
      print('新创建$name');
      final logger = new Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  // 如果一个构造方法并不总是返回一个新的对象，则使用 factory 来定义这个构造方法
  factory Logger.test(String name) {
    if (_cache.containsKey(name)) {
      print('test 旧的 $name');
      return _cache[name];
    } else {
      print('test 新创建 $name');
      final logger = new Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) {
      print(msg);
    }
  }
}

class Rectangle {
  num left;
  num top;
  num width;
  num height;

  Rectangle(this.left, this.top, this.width, this.height);

  // Dart 中每一个属性默认都有 getter 和 setter 方法，我们也可以自定义属性的 getter 和 setter
  num get right => left + width;

  set right(num value) => left = value - width;

//  num get bottom {
//    return top + height;
//  }
  num get bottom => top + height;

  set bottom(num value) => top = value - height;
}

abstract class AbstractContainer {
  void updateChildren(); // Abstract method.
}

// 和 Java 一样使用 enum 定义枚举，不过 Dart 中的枚举不支持定义属性和方法
enum Color { red, green, blue }

testEnum() {
  // 枚举类型中的每个值都有一个 index getter 函数，该函数返回该值是其在枚举类型定义中的位置（从 0 开始）
  assert(Color.red.index == 0);
  assert(Color.green.index == 1);
  assert(Color.blue.index == 2);
  // 枚举的 values 常量可以返回所有的枚举值
  List<Color> colors = Color.values;
  assert(colors[2] == Color.blue);
  // 如果在 switch (e) 中的 e 的类型为枚举类，如果没有处理所有该枚举类型的值的话，则会抛出一个警告
  Color aColor = Color.blue;
  switch (aColor) {
    case Color.red:
      print('Red as roses!');
      break;
    case Color.green:
      print('Green as grass!');
      break;
//    case Color.blue:
//      break;
    default:
      print(aColor);
  }
}

// 给函数起一个别名，使用比较方便，而且还支持泛型。例如定义一个方法的回调，直接使用别名定义
//typedef int Compare<T>(T a, T b);
typedef Compare<T> = int Function(T a, T b);

class SortedCollection {
  Function compare1;
  Compare<int> compare2;

  SortedCollection(int compare1(Object a, Object b), this.compare2) {
    this.compare1 = compare1;
  }
}

int sort1(Object a, Object b) => 0;
int sort2(int a, int b) => a - b;

testTypeDef() {
  SortedCollection coll = new SortedCollection(sort1, sort2);
  print(coll.compare2 is Function); // true
  print(coll.compare2 is Compare<int>); // true
  print(coll.compare1); // Closure: (Object, Object) => int from Function 'sort1': static.
  print(coll.compare2); // Closure: (int, int) => int from Function 'sort2': static.
}

@todo('', '')
testTodo() {

}
class todo {
  final String who;
  final String what;

  const todo(this.who, this.what);
}

abstract class Person {
  // 在接口中，在类中
  int _name;

  // 没在接口中，在类中
  Person(this._name);

  // 在接口和类中
  String test1(who) => 'Person test1：Hello, $who. I am $_name.';

  // 在接口和类中
  String test2() => 'Person test2：I am $_name.';

  // 在接口和类中，抽象方法和接口方法不用写方法体
  String test3();
}

// 将 Person 作为接口使用。Dart 中每个类都是接口，实现接口时必须重写接口里的所有方法
class TestImplements implements Person {
  // 如果接口中有属性，必须重新定义接口中的属性。或者不定义该属性，但要定义其 getter、setter 方法
  @override
  int _name;

//  int get _name => 1;
//  set _name (name) => _name = name;

  @override
  String test1(who) => 'TestImplements test1：Hi $who. Do you know who I am?';

  @override
  String test2() {
    return 'TestImplements test2：I am $_name.';
  }

  @override
  String test3() {
    return 'TestImplements test3';
  }
}

// 将 Person 作为抽象类使用。继承抽象类时必须实现里面的抽象方法，不用像当做接口使用那样重新定义接口中的数据或getter、setter方法
class TestExtends extends Person {
  TestExtends(name) : super(name);

  @override
  String test3() {
    return 'TestExtends test3';
  }
}

testSingleton() {
  SingletonOne singletonOne1 = SingletonOne();
  SingletonOne singletonOne2 = SingletonOne.instance;

  SingletonOne singletonOne3 = SingletonOne._instance;
  SingletonOne singletonOne4 = SingletonOne._internal(); // 不要在单例类外部调用
  print('singletonOne1 is ${singletonOne1.hashCode}');
  print('singletonOne2 is ${singletonOne2.hashCode}');
  print('singletonOne3 is ${singletonOne3.hashCode}');
  print('singletonOne4 is ${singletonOne4.hashCode}');

  SingletonTwo singletonTwo1 = new SingletonTwo();
  SingletonTwo singletonTwo2 = SingletonTwo.instance;

  SingletonTwo singletonTwo3 = SingletonTwo._instance; // 懒汉式时不要这样用
  SingletonTwo singletonTwo4 = SingletonTwo._getInstance();
  SingletonTwo singletonTwo5 = SingletonTwo._internal(); // 不要在单例类外部调用
  print('singletonTwo1 is ${singletonTwo1.hashCode}');
  print('singletonTwo2 is ${singletonTwo2.hashCode}');
  print('singletonTwo3 is ${singletonTwo3.hashCode}');
  print('singletonTwo4 is ${singletonTwo4.hashCode}');
  print('singletonTwo5 is ${singletonTwo5.hashCode}');
}

// 饿汉式
class SingletonOne {
  static final SingletonOne _instance = new SingletonOne._internal();

  static SingletonOne get instance => _instance;

  factory SingletonOne() {
    return _instance;
  }

//  SingletonOne._internal();
  SingletonOne._internal() {
    // 初始化
  }
}

// 懒汉式
class SingletonTwo {
  static SingletonTwo _instance;

  static SingletonTwo get instance => _getInstance();

  factory SingletonTwo() => _getInstance();

  SingletonTwo._internal() {
    // 初始化
  }

  static SingletonTwo _getInstance() {
    if (_instance == null) {
      _instance = new SingletonTwo._internal();
    }
    return _instance;
  }
}

testDynamicAndObject() {
  Object a = 'BGA';
  a = 27;
  a.toString(); // 只能调用 Object 支持的方法

  dynamic b = 'BGA';
  // 可以通过编译，但运行时会报错
//  b.sdf = 1; // NoSuchMethodError: Class 'String' has no instance setter 'sdf='.
//  b.sdfsdf(); // NoSuchMethodError: Class 'String' has no instance method 'sdfsdf'.
//  b[1] = 'b'; // NoSuchMethodError: Class 'String' has no instance method '[]='.

  // Dart 提供了关键字 is 进行类型检测
  if (a is int) {
    // 通过类型检测后 Dart 知道 a 为 int 类型，所以这里不需要强制类型转换
    a.toDouble();
  }
  if (b is String) {
    b.toLowerCase();
  }

  // Dart 也提供了 as 让我们进行类型的强制转换，但为了安全的转换，更推荐使用 is
  (a as int).toDouble();
  (b as String).toLowerCase();
}

testException() {
  try {
    // 可能引发异常的代码
    throw FormatException();
  } on IntegerDivisionByZeroException {
    print('IntegerDivisionByZeroException');

    // 可以重新抛出，错误堆栈信息为原始错误位置
    rethrow;
  } on FormatException catch (e1) {
    print(e1);
    // 抛出异常，错误堆栈信息为当前位置
    throw e1;
  } catch (e2) {
    // 捕获所有异常
    print(e2);
    // 可以重新抛出，错误堆栈信息为原始错误位置
    rethrow;
  } finally {
    print('在 try、on、catch 之后无条件执行可选的 finally 块');
  }
}