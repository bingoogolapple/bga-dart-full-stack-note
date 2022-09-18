main() {
  int a = 2;
  int b;
  int c = 3;
  // ?? 左边的变量为 null 时将右边的值赋值给左边的变量，否则什么也不做
  b ??= a;
  print(b); // 2
  c ??= a;
  print(c); // 3

  String e = a == 2 ? 'BGA' : 'bingoogolapple';
  print(e); // BGA
  String f;
  // ?? 左边的表达式为 null 时取右边表达式的值，否则取左边表达式的值
  String g = f ?? 'bingoogolapple';
  print(g); // bingoogolapple
  String h = 'BGA';
  String i = h ?? 'bingoogolapple';
  print(i); // BGA

  var list = ['BGA', 'bingoogolapple', 'bingo', 'googol', 'apple'];
  for (var index = 0; index < list.length; index++) {
    print(list[index]);
  }
  print('--------------------------');
  for (var item in [1, 3, 5, 7]) {
    BGA:
    for (int i = 0; i < 10; i++) {
      if (i % item == 3) {
        continue BGA;
      }
      print(item);
    }
  }

  var command = 'CLOSED';
  switch (command) {
    case 'CLOSED':
      print('CLOSED');
      continue nowClosed;
    nowClosed:
    case 'NOW_CLOSED':
      print('NOW_CLOSED');
      break;
    default:
      print('UNKNOWN');
      break;
  }
}
