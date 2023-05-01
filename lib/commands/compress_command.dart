import 'dart:io';
import 'package:args/command_runner.dart';

class CompressCommand extends Command {
  @override
  final name = "compress";

  @override
  final description = "Compress files into a specific compression format.";

  @override
  void run() {
    print("Running compress command...");
  }
}
