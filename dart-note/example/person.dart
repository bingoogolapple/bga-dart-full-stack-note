class Person {
  String name;
  int _age;

  Person(this.name) {
    _age = 27;
    print('实例化 example 里的 Person $name');
  }

  @override
  String toString() => 'example 里的 Person[name=$name, age=$_age]';
}