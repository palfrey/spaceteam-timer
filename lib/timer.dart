import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/material.dart';
import 'difficulty.dart';

class TimerScreen extends StatelessWidget {
  final Difficulty difficulty;

  // In the constructor, require a Todo
  TimerScreen({Key key, @required this.difficulty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Run timer'),
        ),
        body: Center(child: Text('run')));
  }
}
