main() {
  test3();
}

test1() {
  RegExp exp = new RegExp(r"(\w+)");
  // 返回正则表达式的哈希码
  print(exp.hashCode);
  // 正则表达式是否区分大小写
  print(exp.isCaseSensitive);
  // 正则表达式是否匹配多行
  print(exp.isMultiLine);
  // 返回源正则表达式字符串
  print(exp.pattern);
  // 返回对象运行时的类型
  print(exp.runtimeType);
}

test2() {
  RegExp exp = new RegExp(r"(\w+)");
  // 返回正则表达式匹配项的可迭代对象
  print(exp.allMatches("abc def ghi")); // (Instance of '_RegExpMatch', Instance of '_RegExpMatch', Instance of '_RegExpMatch')
  // 搜索并返回第一个匹配项，没有则返回null
  print(exp.firstMatch("de")); // Instance of '_RegExpMatch'
  // 正则表达式是否找到匹配项
  print(exp.hasMatch("adsdf")); // true
  // 从第几个字符开始匹配正则表达式
  print(exp.matchAsPrefix("ab cd", 3)); // Instance of '_RegExpMatch'
  // 返回正则表达式的第一个匹配字符串
  print(exp.stringMatch("abc de")); // abc
  // 返回正则表达式的字符串表示
  print(exp.toString()); // RegExp: pattern=(\w+) flags=
}

test3() {
  // 验证邮政编码的正则，返回是否匹配的布尔值
  RegExp postalCode = new RegExp(r'(\d{6})');
  print(postalCode.hasMatch("518000"));

  // 验证手机号码的正则，以Iterable< Match >返回所有匹配项
  RegExp mobile = new RegExp(r"(0|86|17951)?(13[0-9]|15[0-35-9]|17[0678]|18[0-9]|14[57])[0-9]{8}");
  Iterable<Match> mobiles = mobile.allMatches("13812345678 12345678901 17012345678");
  for (Match m in mobiles) {
    String match = m.group(0);
    print(match);
  }

  // 验证网址URL的正则，如果匹配成功以Match返回匹配项，否则返回null
  RegExp url = new RegExp(r"^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+");
  print(url.firstMatch("http://www.google.com"));

  // 验证身份证号码的正则，返回第一个匹配的字符串
  RegExp identity = new RegExp(r"\d{17}[\d|x]|\d{15}");
  print(identity.stringMatch("My id number is 35082419931023527x"));
}
