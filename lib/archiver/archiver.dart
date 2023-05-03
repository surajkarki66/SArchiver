import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:cli_spinner/cli_spinner.dart';

import 'package:archive/archive_io.dart';

class Archiver {
  Archiver(
      {required this.inputPath,
      required this.outputFilePath,
      required this.format}) {
    try {
      spinner = Spinner.type("Loading...", SpinnerType.clocks);
      if (inputPath is! List<String>) {
        inputFileStream = InputFileStream(inputPath);
      }
    } catch (e) {
      stderr.writeln(e.toString().substring(e.toString().indexOf(':') + 1));
      exit(1);
    }
  }

  final dynamic inputPath;
  final String outputFilePath;
  final String format;
  late final Spinner spinner;
  late final InputFileStream inputFileStream;

  void compress() {
    switch (format) {
      case "zip":
        _performCompress(format: format, encoder: ZipEncoder());
        break;

      case "tar":
        _performCompress(format: format, encoder: TarEncoder());
        break;

      default:
        stderr.writeln("Compression format is not supported.");
        exit(1);
    }
  }

  void decompress() {
    switch (format) {
      case ".zip":
        _performDecompress(
            format: format,
            archive: ZipDecoder().decodeBuffer(inputFileStream, verify: true));
        break;

      case ".tar":
        _performDecompress(
            format: format,
            archive: TarDecoder().decodeBuffer(inputFileStream, verify: true));
        break;

      default:
        stderr.writeln("Compression format is not supported.");
        exit(1);
    }
  }

  void _performCompress(
      {required String format, required dynamic encoder}) async {
    try {
      spinner.start();
      final archive = Archive();
      final outputDir = path.join(
          outputFilePath, '${DateTime.now().millisecondsSinceEpoch}.$format');

      for (var i in inputPath) {
        final inputFile = File(i);
        final inputDir = Directory(i);
        if (await inputFile.exists()) {
          final archiveFile = await inputFile.readAsBytes();
          archive.addFile(
              ArchiveFile(inputFile.path, archiveFile.length, archiveFile));
        } else if (await inputDir.exists()) {
          final files = inputDir.listSync(recursive: true);

          for (var file in files) {
            if (file is Directory) {
              continue;
            }

            final archiveFile = await File(file.path).readAsBytes();
            final archivePath = file.path.substring(inputDir.path.length);
            archive.addFile(
                ArchiveFile(archivePath, archiveFile.length, archiveFile));
          }
        } else {
          spinner.stop();
          stderr.writeln('Input path does not exist: $i');
          exit(1);
        }
      }
      final output = File(outputDir);
      await output.writeAsBytes(encoder.encode(archive)!);
      spinner.stop();
      stdout.writeln('Compressed ${inputPath.length}  into ${output.path}');
    } catch (e) {
      spinner.stop();
      stderr.writeln(e.toString().substring(e.toString().indexOf(':') + 1));
      exit(1);
    }
  }

  void _performDecompress({required String format, required Archive archive}) {
    try {
      spinner.start();
      for (var file in archive.files) {
        stdout.writeln("Decompressed: ${file.name} (${file.size} bytes)");
        if (file.isFile) {
          final outputStream =
              OutputFileStream(path.join(outputFilePath, file.name));

          file.writeContent(outputStream);
          outputStream.close();
        }
      }
      spinner.stop();
    } catch (e) {
      spinner.stop();
      stderr.writeln(e.toString().substring(e.toString().indexOf(':') + 1));
      exit(1);
    }
  }
}
