import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'package:sarchiver/commands/compress_command.dart';
import 'package:sarchiver/commands/decompress_command.dart';

void main(List<String> args) async {
  try {
    final runner = CustomCommandRunner()
      ..addCommand(CompressCommand())
      ..addCommand(DecompressCommand());

    await runner.run(args);
  } catch (e) {
    stderr.writeln(e.toString());
  }
}

class CustomCommandRunner extends CommandRunner<void> {
  static const String appVersion = '0.0.3';

  CustomCommandRunner() : super('sarchiver', '''
SArchiver (v$appVersion)

A CLI app to compress and decompress various files into various compression formats. Supported compression formats: Zip, Tar ''') {
    argParser.addFlag(
      'version',
      abbr: "v",
      negatable: false,
      help: 'Prints the application version.',
    );
  }

  @override
  Future<void> runCommand(ArgResults topLevelResults) async {
    if (topLevelResults["version"]) {
      stdout.writeln(appVersion);
      return;
    }
    return await super.runCommand(topLevelResults);
  }
}
