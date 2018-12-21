import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/material.dart';
import 'difficulty.dart';
import 'setup.dart';

class TimerScreen extends StatelessWidget {
  final Difficulty difficulty;

  // In the constructor, require a Todo
  TimerScreen({Key key, @required this.difficulty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterSound flutterSound = new FlutterSound();
    pathForLength(lengthForDifficulty(difficulty)).then((path) {
      return flutterSound.startPlayer('file://$path');
    }).then((result) {
      print('startPlayer: $result');
      flutterSound.onPlayerStateChanged.listen((e) {
        if (e != null) {
          print('event: $e');
        }
      });
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('Run timer'),
        ),
        body: Center(child: Text('run')));
  }
}
