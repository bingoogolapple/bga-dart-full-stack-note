import 'package:args/args.dart';
import 'package:args/command_runner.dart';

// https://pub.dartlang.org/packages/args
main(List<String> args) {
  var parser = ArgParser();
  // --mode=release    --mode    release    -mrelease    -m    release
  parser.addOption('mode', abbr: 'm', allowed: ['debug', 'release'], defaultsTo: 'debug', callback: (mode) => print('Got mode $mode'));
  // 逗号分隔不能有空格 -p 100,200     -p 100 -p 200    逗号分隔不能有空格 --port 100,200    逗号分隔不能有空格 --port=100,200    --port 100 --port 200
  parser.addMultiOption('port', abbr: 'p');

  // --verbose    -v
  parser.addFlag('verbose', abbr: 'v', defaultsTo: false, callback: (verbose) {
    if (verbose) print('Verbose');
  });
  // --iambic    -i    -iv
  parser.addFlag('iambic', abbr: 'i', defaultsTo: false, callback: (iambic) {
    if (iambic) print('Iambic');
  });

  parser.addFlag('all', abbr: 'a');
  parser.addCommand('commit').addFlag('all', abbr: 'a');
  // 作为 parser 参数「-a commit」，作为 commit 的参数「commit -a」
  parser.addCommand('pcommand').addCommand('childCommand').addFlag('haha', abbr: 'h');

  var results = parser.parse(args);

  if (results.command == null) {
    print(parser.usage);
  } else {
    print(results['mode']);
    print(results['verbose']);
    print(results['iambic']);
    print(results['port']);

    switch (results.command.name) {
      case 'commit':
        print(results.command['all']);
        break;
      case 'pcommand':
        print(results.command.command['haha']);
        break;
      default:
        print('未识别');
        break;
    }
  }

  new CommandRunner("git", "Distributed version control.")
    ..addCommand(new StatusCommand())
    ..addCommand(new FetchCommand())
    ..run(args).catchError((error) {
      if (error is! UsageException) throw error;
      print(error);
    });
}

class StatusCommand extends Command {
  // The [name] and [description] properties must be defined by every subclass.
//  final name = "status";
  String get name => 'status';
  final description = "显示仓库状态";

  StatusCommand() {
    // [argParser] is automatically created by the parent class.
    argParser.addFlag('verbose', abbr: 'v');
  }

  // [run] may also return a Future.
  @override
  void run() {
    // [argResults] is set before [run()] is called and contains the options passed to this command.
    print("StatusCommand ${argResults['verbose']}");
  }
}

class FetchCommand extends Command {
  String get name => 'fetch';
  final description = "获取远程仓库代码";

  StatusCommand() {
    argParser.addFlag('verbose', abbr: 'v');
  }

  @override
  void run() {
    print("FetchCommand ${argResults['verbose']}");
  }
}
