/// # 学习发布 Dart 库发布
///
/// ## 测试 Markdown

export 'src/person.dart';
export 'src/student.dart';
export 'src/animal.dart';
export 'src/flyer.dart';
export 'src/walker.dart';
export 'src/swimmer.dart';

// 预发布，看是否满足发布条件，pub publish -n -v
// 正真发布，一定要加 sudo，sudo pub publish -v
