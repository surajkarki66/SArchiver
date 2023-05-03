import 'dart:io';

import 'package:args/command_runner.dart';

import 'package:sarchiver/commands/compress_command.dart';
import 'package:sarchiver/commands/decompress_command.dart';

void main(List<String> args) async {
  try {
    final runner = CommandRunner('sarchiver',
        '''A CLI app to compress and decompress various files into various compression formats. Supported compression formats: Zip, Tar ''')
      ..addCommand(CompressCommand())
      ..addCommand(DecompressCommand());

    await runner.run(args);
  } catch (e) {
    stderr.writeln(e.toString());
  }
}
