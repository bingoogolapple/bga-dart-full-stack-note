part 'mammal.dart';

part 'bird.dart';

part 'fish.dart';

/// # 学习发布 Dart 库
///
/// ## 测试 Markdown
abstract class Animal {
  eat() {
    print("${runtimeType} eating");
  }
}

/*

part 与 import 有什么区别

可见性：
* 如果说在 A 库中 import 了 B 库，A 库对 B 库是不可见的，也就是说 B 库是无法知道 A 库的存在的
* 而 part 的作用是将一个库拆分成较小的组件。两个或多个 part 共同构成了一个库，它们彼此之间是知道互相的存在的

作用域：
* import 不会完全共享作用域，而 part 之间是完全共享的
* 如果说在 A 库中 import 了 B 库，B 库 import 了 C 库，A 库是没有办法直接使用 C 库的对象的
* 而 B、C 若是 A 的 part，那么三者共享所有对象。并且包含所有导入

*/
