class Person {
  String name;
  int _age;

  int get age => _age;

  Person(this.name) {
    _age = 27;
    print('实例 lib 里的 Person $name');
  }

  @override
  String toString() => 'lib 里的 Person[name=$name, age=$_age]';
}
