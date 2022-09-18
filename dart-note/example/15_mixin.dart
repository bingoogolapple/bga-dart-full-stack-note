/**
 * 假设我们有两个类 S、A，现在需要使用 mixin 定义类 T「class T = A with S;」
 * 那我们得到的 class T 是怎么样的呢？假设 MA 表示 A 中的所有方法，MS 表示 S 中的所有方法，那么 T 中的方法集合为「MS U (MA - MS)」，即 T 中的方法为 A 和 S 方法的集合，如果有重复，取 S 中的
 * 复杂一点的情况「class T = B with A, S;」相当于「class T = (B with A) with S;」
 *
 * 属性和方法是一样的
 */
class S {
  a() {
    print("S.a");
  }
}

class A {
  a() {
    print("A.a");
  }

  b() {
    print("A.b");
  }
}

class B {
  a() {
    print("B.a");
  }

  b() {
    print("B.b");
  }

  c() {
    print("B.c ");
  }
}

/**
 * Dart 中的 mixin 通过创建一个新类来实现「它还会创建一个新接口，因为所有 Dart 类也定义了接口」，该类将 mixin 的实现层叠在一个超类之上以创建一个新类，它不是「在超类中」，而是在超类的「顶部」
 * 1.mixin 不是一种在经典意义上获得多重继承的方法
 * 2.mixin 是一种抽象和重用一系列操作和状态的方法
 * 3.mixin 类似于扩展类所获得的重用，但它与单继承兼容，因为它是线性的
 *
 * 什么时候应该使用 mixin？
 * 当我们想要在不共享相同类层次结构的多个类之间共享行为时，或者在超类中实现此类行为没有意义时，mixin 非常有用，例如：序列化
 */
class AS = A with S;

//class RealAS extends AS {
class RAS extends A with S {
  a() {
    print('RAS.a');
  }

  b() {
    print('RAS.b');
  }
}

class BAS = B with A, S;

class RealBAS extends BAS {}

//class RBAS extends RealBAS {
class RBAS extends B with A, S {
  a() {
    print('RBAS.a');
  }

  b() {
    print('RBAS.b');
  }

  c() {
    print('RBAS.c');
  }
}

testAs() {
  AS a = new AS();
  a.a(); // S.a
  a.b(); // A.b
  print('-----------------');
  RAS ra = new RAS();
  ra.a(); // RAS.a
  ra.b(); // RAS.b
  print('-----------------');
}

testBas() {
  BAS b = new BAS();
  b.a(); // S.a
  b.b(); // A.b
  b.c(); // B.c
  print('-----------------');

  RBAS rb = new RBAS();
  rb.a(); // RBAS.a
  rb.b(); // RBAS.b
  rb.c(); // RBAS.c
  print('-----------------');
}

// -------------------------------------------------------------------------------------

abstract class Animal {
  eat() {
    print("${runtimeType} eating");
  }
}

// 哺乳动物
abstract class Mammal extends Animal {}

abstract class Bird extends Animal {}

abstract class Fish extends Animal {}

/**
 * 加上 abstract 变成抽象类 => 限制被实例化
 * Error: The class 'Flyer' is abstract and can't be instantiated
 */
abstract class Flyer {
  String name = "飞";
  /**
   * 没有未命名的无参构造方法 => 限制被继承
   * Error: The superclass, 'Flyer', has no unnamed constructor that takes no arguments
   */
  factory Flyer._() => null;

  fly() {
    print("${runtimeType} flying");
  }
}

/**
 * 或者直接使用 mixin 关键字定义 mixin，默认限制了不能被继承、不能被实例化
 * Error: The type 'Swimmer' can't be used as supertype
 * Error: The class 'Swimmer' is abstract and can't be instantiated
 */
mixin Swimmer {
  String name = "游泳";

  swim() {
    print("${runtimeType} swimming");
  }
}

// on 关键字表示使用这个 mixin 时，这个类必须「继承或实现」Animal，因为 mixin 使用了 Animal 提供的功能（既 eat 方法）
mixin Walker on Animal {
  String name = "走路";

  walk() {
    print("${runtimeType} walking");
    super.eat();
  }
}

// 海豚
class Dolphin extends Mammal with Swimmer {}

// 蝙蝠
//class Bat extends Mammal with Walker, Flyer {}
class Bat = Mammal with Walker, Flyer;

class UnknownAnimal extends Animal with Walker {}

class Cat extends Mammal with Walker {}

// 鸽子
class Dove extends Bird with Walker, Flyer {}

// 鸭子
class Duck extends Bird with Walker, Swimmer, Flyer {
  String name = "鸭子";
}

// 鲨鱼
class Shark extends Fish with Swimmer {}

class FlyingFish extends Fish with Swimmer, Flyer {}

testAnimal() {
  // UnknownAnimal walking
  // UnknownAnimal eating
  new UnknownAnimal().walk();
  // Bat flying
  new Bat()..fly();
  // Dove flying
  // Dove walking
  // Dove eating
  // 飞
  Dove dove = new Dove()
    ..fly()
    ..walk();
  print(dove.name);
  // Duck flying
  // Duck walking
  // Duck eating
  // Duck swimming
  // 鸭子 因为鸭子类里复写了 name 属性
  Duck duck = new Duck()
    ..fly()
    ..walk()
    ..swim();
  print(duck.name);
}

main() {
  testAs();
  testBas();
  testAnimal();
}
