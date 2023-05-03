import 'dart:io';
import 'package:args/command_runner.dart';

import 'package:sarchiver/archiver/archiver.dart';

class CompressCommand extends Command {
  CompressCommand() {
    argParser
      ..addMultiOption(
        'input-path',
        abbr: 'i',
        help: 'Specify path to input file or directory',
      )
      ..addOption('output-file-path',
          abbr: 'o',
          defaultsTo: Directory.current.path,
          help: 'Specify path to store compressed file')
      ..addOption('format',
          abbr: 'f',
          allowed: ["zip", "tar"],
          defaultsTo: "zip",
          help: 'Specify compression file format');
  }

  @override
  final name = "compress";

  @override
  final description = "Compress files into a specific compression format.";

  @override
  void run() {
    final bool? isInputPathParsed = argResults?.wasParsed("input-path");

    if (isInputPathParsed!) {
      final Archiver archiver = Archiver(
          inputPath: argResults?["input-path"],
          outputFilePath: argResults?["output-file-path"],
          format: argResults?["format"]);
      archiver.compress();
    } else {
      stderr.write("Option --input-path or -i is mandatory.\n");
    }
  }
}
