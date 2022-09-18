import 'animal.dart';

mixin Walker on Animal {
  walk() {
    print("${runtimeType} walking");
    super.eat();
  }
}
