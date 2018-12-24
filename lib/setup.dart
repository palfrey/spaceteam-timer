import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

Future<String> _localPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<String> pathForLength(int i) async {
  final path = await _localPath();
  return "$path/$i+Min+Spaceteam+Timer.mp3";
}

Future<void> setupMusicFiles() async {
  for (var i in [3, 5, 7]) {
    final storePath = await pathForLength(i);
    final f = File(storePath);
    if (!await f.exists()) {
      final assetKey = "assets/music/$i+Min+Spaceteam+Timer.mp3";
      var data = await rootBundle.load(assetKey);
      await f.writeAsBytes(data.buffer.asInt8List());
    }
  }
}
