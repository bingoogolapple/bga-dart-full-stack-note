import 'dart:mirrors';

main() {
  var person = testNewInstance();
  // 也可以在实例上调用 runtimeType 获取该对象的 Type，然后再通过 reflectClass 获取 ClassMirror
  ClassMirror classMirror = reflectClass(person.runtimeType);
  // 也可以将一个实例作为 reflect 方法的参数来获取到 InstanceMirror
  InstanceMirror instanceMirror = reflect(person);
  // 通过 reflectee 获取反射的目标对象，通过 identical 检测两个引用是否为同一个对象
  print(identical(instanceMirror.reflectee, person)); // true

  showConstructors(classMirror);

  showFields(classMirror);

  invokeMethod(instanceMirror);

  invokeGetterSetter(person, instanceMirror);

  testGenericType(person);
}

// 通过反射实例化 Person 对象
Person testNewInstance() {
  // 如果在写代码的时候，已经知道 symbol 的名字了，则可以使用「#符号名字」的方式直接使用
  Symbol classSymbol = #Person;
  print(MirrorSystem.getName(classSymbol));

  // 在开始使用之前，需要将一个类作为 reflectClass 方法的参数来获取到 ClassMirror
  ClassMirror classMirror = reflectClass(Person);
  // 通过 newInstance 创建 InstanceMirror 实例
  InstanceMirror instanceMirror = classMirror.newInstance(Symbol("test"), ['BGA', 'bingoogolapple', 27]);
  // 通过 reflectee 获取反射的目标对象
  dynamic person = instanceMirror.reflectee;
  // Dart 提供了关键字 is 进行类型检测
  if (person is Person) {
    print('有通过 newInstance 实例化');
    // 通过类型检测后 Dart 知道 person 为 Person 类型，所以这里不需要强制类型转换
    print(person.age);
    print(person.full);
    print(person.fullName);
    return person;
  } else {
    print('没有通过 newInstance 实例化');
    return null;
  }
}

// 列出类的所有构造函数
showConstructors(ClassMirror classMirror) {
  List<MethodMirror> constructors = classMirror.declarations.values.where((m) => m is MethodMirror && m.isConstructor).map((m) => m as MethodMirror).toList();

  StringBuffer resultSb = StringBuffer();
  constructors.forEach((m) {
    resultSb.writeln('The constructor ${m.simpleName} has ${m.parameters.length} parameters:');
    m.parameters.forEach((parameter) => resultSb.writeln(parameter.simpleName));
  });
  print(resultSb.toString());
}

// 列出类的成员变量
showFields(ClassMirror classMirror) {
  List<VariableMirror> fields = classMirror.declarations.values.where((m) => m is VariableMirror).map((f) => f as VariableMirror).toList();

  fields.forEach((VariableMirror m) {
    var finalStatus = m.isFinal ? 'final' : 'not final';
    var privateStatus = m.isPrivate ? 'private' : 'not private';
    var typeAnnotation = m.type.simpleName;
    print('The field ${m.simpleName} is $privateStatus ' + 'and $finalStatus and is annotated as ' + '$typeAnnotation.');
  });
}

// 使用 InstanceMirror 的 invoke 方法来调用对象的方法
invokeMethod(InstanceMirror instanceMirror) {
  // 第一个参数为要调用的方法名字，第二个参数为该方法的位置参数 list。第三个参数为该方法的命名参数 map
  instanceMirror.invoke(#testPositionParam, [1, 2]);
  instanceMirror.invoke(#testPositionParam, [1, 2, 3]);
  instanceMirror.invoke(#testPositionParam, [1, 2, 3, 4]);

  instanceMirror.invoke(#testNamedParam, [1, 2]);
  instanceMirror.invoke(#testNamedParam, [1, 2], {#p3: 3});
  instanceMirror.invoke(#testNamedParam, [1, 2], {#p3: 3, #p4: 4});
}

// 执行 getter 和 setter 方法
invokeGetterSetter(Person person, InstanceMirror instanceMirror) {
  // 获取属性
  var fullName = instanceMirror.getField(#full).reflectee;
  print(fullName);

  // 设置属性
  instanceMirror.setField(#full, '王浩');
  print(person.full);
  print(person.fullName);
}

// 获取泛型
testGenericType(Person person) {
  ClosureMirror closureMirror = reflect(person.test);
  ParameterMirror parameterMirror = closureMirror.function.parameters.first;
  print(MirrorSystem.getName(parameterMirror.simpleName));
  TypeMirror typeMirror = parameterMirror.type;
  print(MirrorSystem.getName(typeMirror.simpleName));
  print(MirrorSystem.getName(typeMirror.typeArguments[0].simpleName));
  print(MirrorSystem.getName(typeMirror.typeVariables[0].simpleName));
}

class Person {
  String abbr;
  String full;
  int age;

  Person(this.abbr, this.full, this.age);

  // 命名构造方法
  Person.test(this.abbr, this.full, this.age);

  String get fullName => '$abbr $full';

  // 位置可选参数，必须在最后
  testPositionParam(p1, p2, [p3, p4]) {
    print('testPositionParam p1 = $p1, p2 = $p2, p3 = $p3, p4 = $p4');
  }

  // 命名可选参数，必须在最后
  testNamedParam(p1, p2, {p3, p4}) {
    print('testNamedParam p1 = $p1, p2 = $p2, p3 = $p3, p4 = $p4');
  }

  // 用于测试获取泛型参数
  test(List<String> p) {}
}
