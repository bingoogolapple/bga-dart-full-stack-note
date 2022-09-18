import 'package:bga_dart_note/bga_dart_note.dart' as lib; // 使用 as 关键字为导入的库设置命名空间，使用时通过「命名空间.类名」
import 'package:bga_dart_note/bga_dart_note.dart' hide Person; // 除了 Person 类，其他的类都导入
import 'package:bga_dart_note/bga_dart_note.dart' show Student; // 只导入 Student 类
import 'person.dart' as example;
import 'package:bga_dart_note/src/student.dart'; // 也可以通过「库名称/库里 dart 文件路劲」导入

void main() {
  var person = Person('BGA');
  print(person._age);
  var libPerson = lib.Person('BGA');
  // 没有访问权限
//  libPerson._age;
  var examplePerson = example.Person('BGA');
  // 没有访问权限
//  examplePerson._age;
  print(examplePerson);

  Student student = new Student('王浩');
  student = new lib.Student('BGA');
  student.id = 'sdfsdfsdfsd';
  print(student);

  Duck()..walk()..fly()..swim();
}

class Person {
  String name;
  int _age;

  Person(this.name) {
    _age = 17;
    print('实例化 demo 里的 Person $name');
  }

  @override
  String toString() => 'demo 里的 Person[name=$name, age=$_age]';
}

class Duck extends Bird with Walker, Swimmer, Flyer {}