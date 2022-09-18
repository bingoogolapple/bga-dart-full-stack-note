import 'dart:io';

main() {
//  printEnv();
  testShell();
}

void printEnv() {
  print('操作系统=> ${Platform.operatingSystem}'); // macos
  print(
      '操作系统版本=> ${Platform.operatingSystemVersion}'); // Darwin 17.7.0 Darwin Kernel Version 17.7.0: Wed Apr 24 21:17:24 PDT 2019; root:xnu-4570.71.45~1/RELEASE_X86_64
  print('CPU 核数=> ${Platform.numberOfProcessors}'); // 8
  print('文件 URI=> ${Platform.script}'); // file:///Users/wanghao/git/IDEA/BGA/dart-note/example/20_env_shell.dart
  print(
      '文件路径=> ${Platform.script.toFilePath(windows: Platform.isWindows)}'); // windows参数来区分正反斜杠 /Users/wanghao/git/IDEA/BGA/dart-note/example/20_env_shell.dart
  print('localeName=> ${Platform.localeName}'); // zh-Hans-CN
  print('localHostname=> ${Platform.localHostname}'); // wanghao.local
  print('pathSeparator=> ${Platform.pathSeparator}'); // /
  print('packageConfig=> ${Platform.packageConfig}'); // null
  print('executable=> ${Platform.executable}'); // /Applications/develop/dart-sdk/bin/dart
  print('Dart 版本=> ${Platform.version}'); // 2.5.1 (Fri Sep 27 12:28:49 2019 +0200) on "macos_x64"

  for (String value in Platform.executableArguments) {
    // --enable-asserts
    // --enable-vm-service:61356
    print(value);
  }
  // 查看环境变量
  Platform.environment.forEach((key, value) {
    print('$key : $value');
  });
}

void testShell() {
  /**
   * ProcessStartMode.NORMAL，默认值，新运行的程序作为主程序的子进程，并通过数据流 stdin stdout stderr 连接通信
   * ProcessStartMode.DETACHED 创建一个独立的进程，与主进程无数据流连接，主进程只能获得子进程的 pid，关闭主进程后，对其没有影响
   * ProcessStartMode.DETACHED_WITH_STDIO 创建一个独立的进程，但是与主进程可以通过数据流 stdin stdout stderr 连接
   *
   * Process.start 的特点是可以通过数据流和子进程进行交互
   */
//  Process.start("git", ['status', '-v'], workingDirectory: '/Users/wanghao/git/IDEA/BGA/dsl-note', environment: {}, includeParentEnvironment: true, runInShell: false, mode: ProcessStartMode.normal).then((Process process) {
//    // 如果原文有中文等特殊字符，字节列表在转换为 String 的时候，需要对字节列表进行重新编码
//    process.stdout.transform(systemEncoding.decoder).listen((data) {
//      // print(data) 用于输出一行，stdout 用于输出接收到的字节串
//      stdout.add(utf8.encode(data));
//      // print(data);
//    });
//  });

  /**
   * 创建一个子进程，并且父进程和子进程不能交互，之后返回运行结果 stdout 和 stderr 默认编码为 SYSTEM_ENCODING，可在 Process.run 的命名可选参数中设置
   */
  Process.run('git', ['status', '-v'],
          workingDirectory: '/Users/wanghao/git/IDEA/BGA/dsl-note',
          environment: {},
          includeParentEnvironment: true,
          runInShell: false,
          stdoutEncoding: systemEncoding,
          stderrEncoding: systemEncoding)
      .then((ProcessResult result) {
    stdout.write(result.exitCode);
    stdout.write(result.stdout);
    stderr.write(result.stderr);
  });
}
