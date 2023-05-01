import 'dart:io';
import 'package:args/command_runner.dart';

class DecompressCommand extends Command {
  @override
  final name = "decompress";

  @override
  final description = "Decompress the compressed file into original files.";

  @override
  void run() {
    print("Running decompress command...");
  }
}
