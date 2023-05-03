import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:args/command_runner.dart';

import 'package:sarchiver/archiver/archiver.dart';

class DecompressCommand extends Command {
  DecompressCommand() {
    argParser
      ..addOption(
        'input-file-path',
        abbr: 'i',
        help: 'Specify path to input compressed file',
      )
      ..addOption('output-file-path',
          abbr: 'o',
          defaultsTo: Directory.current.path,
          help: 'Specify path to store decompressed file');
  }

  @override
  final name = "decompress";

  @override
  final description = "Decompress the compressed file into original files.";

  @override
  void run() {
    final bool? isInputFilePathParsed =
        argResults?.wasParsed("input-file-path");
    if (isInputFilePathParsed!) {
      final Archiver archiver = Archiver(
          inputPath: argResults?["input-file-path"],
          outputFilePath: argResults?["output-file-path"],
          format: path.extension(argResults?["input-file-path"]));

      archiver.decompress();
    } else {
      stderr.write("Option --input-file-path or -i is mandatory.\n");
    }
  }
}
