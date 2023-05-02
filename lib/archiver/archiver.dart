import 'dart:io';

import 'package:archive/archive_io.dart';

class Archiver {
  Archiver(
      {required this.inputFilePath,
      required this.outputFilePath,
      required this.format}) {
    try {
      inputFileStream = InputFileStream(inputFilePath);
    } catch (e) {
      stderr.writeln(e.toString().substring(e.toString().indexOf(':') + 1));
      exit(1);
    }
  }

  final String inputFilePath;
  final String outputFilePath;
  final String format;
  late final InputFileStream inputFileStream;

  void compress() {}

  void decompress() {
    try {
      final archive =
          _getArchive(format: format, inputFileStream: inputFileStream);

      for (var file in archive!.files) {
        stdout.writeln("Decompressed: ${file.name} (${file.size} bytes)");
        if (file.isFile) {
          final outputStream = OutputFileStream('$outputFilePath/${file.name}');

          file.writeContent(outputStream);

          outputStream.close();
        }
      }
    } catch (e) {
      stderr.writeln(e.toString().substring(e.toString().indexOf(':') + 1));
      exit(1);
    }
  }

  dynamic _getArchive(
      {required String format, required InputFileStream inputFileStream}) {
    switch (format) {
      case ".zip":
        return ZipDecoder().decodeBuffer(inputFileStream, verify: true);

      case ".tar":
        return TarDecoder().decodeBuffer(inputFileStream, verify: true);

      default:
        stderr.writeln("Compression format is not supported.");
        exit(1);
    }
  }
}
