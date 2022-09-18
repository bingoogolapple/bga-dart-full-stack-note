main() {
  testList();
  testSet();
}

testList() {
  var a = [1, 4, 3, 1, 5, 2];
  print(a);
  print(a.length);
  a.add(6);
  print(a);
  a.remove(1);
  print(a);
  a.removeAt(2);
  print(a);
  a.sort(); // 默认是升序
  print(a);
  print(a.runtimeType); // List<int>

  for (int i = 0; i < a.length; i++) {
    print(a[i]);
  }
  for (int item in a) {
    print(item);
  }
  a.forEach((item) {
    print(item);
  });

  // 加上 const 创建不可变 List
  var b = const [1, 5, "BGA", 3, true, 2, 4];
  print(b.runtimeType); // List<Object>
  // Unsupported operation: Cannot add to an unmodifiable list
//  b.add(6);
  print(b);
  b.forEach(print);
  b = const [1, 5];
  b = [1, 5];

  // 这种方式不能生成不可变列表
  var c = List(); // []
  print(c);
  print(c.runtimeType); // List<dynamic>

  var d = List<int>(); // []
  print(d);
  print(d.runtimeType); // List<int>

  var e = List(5); // [null, null, null, null, null]
  print(e);
  print(e.runtimeType); // List<dynamic>

  var f = List<dynamic>();
  f.add(true);
  f.add("BGA");
  f.add(3);
  print(f.runtimeType); // List<dynamic>

  var g = List<Object>();
  g.add(true);
  g.add("BGA");
  g.add(3);
  print(g.runtimeType); // List<Object>

  print([0, 1, 2, 3, 4, 5].sublist(1, 3)); // 包含开始，不包含结尾，[1, 2]
}

testSet() {
  var a = Set();
  print(a.runtimeType); // _CompactLinkedHashSet<dynamic>
  a.add(true);
  print(a.runtimeType); // _CompactLinkedHashSet<dynamic>
  a.add('BGA');
  print(a.runtimeType); // _CompactLinkedHashSet<dynamic>
  var b = Set<String>();
  b.add('BGA');
  print(b.runtimeType); // _CompactLinkedHashSet<String>
  var c = {true, 'BGA', 'BGA'};
  print(c); // {true, BGA}
  print(c.runtimeType); // _CompactLinkedHashSet<Object>
  print({1, 2, 3, 4}.difference({1, 3, 5})); // 求差集 {2, 4}
  print({1, 2, 3, 4}.union({1, 3, 5})); // 求差集 {1, 2, 3, 4, 5}
  // 可以通过 List 的 toSet 方法生成
  print([1, 1, 2, 2, 3, 3].toSet()); // {1, 2, 3}
}
