main() {
  var holder = 'green';
  var a = {"red": 'ff0000', holder: '00ff00', 1: 333};
  print(a.runtimeType); // _InternalLinkedHashMap<Object, Object>
  print(a['red']);
  print(a.length);
  print(a.isEmpty);
  print(a.keys);
  print(a.values);
  print(a.remove('red'));
  print(a);
  // 同时遍历 key 和 value
  a.forEach((key, value) {
    print("key is $key, value is $value");
  });
  // 只遍历 key
  a.keys.forEach((key) {
    print(key);
  });
  // 只遍历 value
  a.values.forEach((value) {
    print(value);
  });

  var b = {"red": 'ff0000', "green": '00ff00', "blur": '0000ff'};
  print(b.runtimeType); // _InternalLinkedHashMap<String, String>
  // 加上 const 创建不可变 Map
  var c = const {"red": 'ff0000', "green": '00ff00', "blur": '0000ff'};
  // Unsupported operation: Cannot set value in unmodifiable Map
//  c['red'] = 'ffffff';
  print(c.runtimeType); // _ImmutableMap<String, String>

  var d = Map();
  d['red'] = 'ff0000';
  print(d.runtimeType); // _InternalLinkedHashMap<dynamic, dynamic>
  var e = Map<String, String>();
  print(e.runtimeType); // _InternalLinkedHashMap<String, String>
}
