import 'person.dart';

class Student extends Person {
  Student(String name) : super(name);

  String id = '';

  String toString() => '[name=$name, age=$age, id=$id]';
}
