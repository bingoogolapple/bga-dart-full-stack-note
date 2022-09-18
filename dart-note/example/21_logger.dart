import 'package:logging/logging.dart';

main() {
  Logger.root.level = Level.WARNING;
  Logger.root.onRecord.listen((LogRecord record) {
    print('${record.loggerName}:${record.level.name}:${record.time}:${record.message}');
    if (record.error != null && record.stackTrace != null) {
      print('-' * 100);
      print('${record.error}\n${record.stackTrace}');
      print('-' * 100);
    }
  });
  Logger logger = Logger('BGA.dart');
  // 默认设置非根节点级别的时候，会抛出异常。如果要对每个节点设置不同的级别，可以打开 hierarchicalLoggingEnabled 开关。
  // 这时候如果我们设置某节点 Level，则该节点以及 children 的 Level 都会设置为同一值，但不影响父节点。
  hierarchicalLoggingEnabled = true;
  logger.level = Level.ALL;
  print(logger.fullName); // BGA.dart
  print(logger.name); // BGA.dart

  logger.config('config msg');
  logger.info('info msg');
  logger.warning('message msg');
  logger.severe('severe msg');

  try {
    var x;
    var y = x / 3;
  } catch (error, stackTrace) {
    logger.shout("ssssss", error, stackTrace);
  }
}
