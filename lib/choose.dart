import 'package:flutter/material.dart';
import 'difficulty.dart';
import 'timer.dart';

class TimerSelect extends StatelessWidget {
  void selectDifficulty(BuildContext context, Difficulty level) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TimerScreen(difficulty: level),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spaceteam Timer'),
      ),
      body: Center(
          child: Column(children: <Widget>[
        Text(
          'Select difficulty',
          style: TextStyle(fontSize: 24.0),
        ),
        RaisedButton(
            child: Text('Easy (7 minutes)'),
            onPressed: () {
              selectDifficulty(context, Difficulty.Easy);
            }),
        RaisedButton(
            child: Text('Medium (5 minutes)'),
            onPressed: () {
              selectDifficulty(context, Difficulty.Medium);
            }),
        RaisedButton(
            child: Text('Hard (3 minutes)'),
            onPressed: () {
              selectDifficulty(context, Difficulty.Hard);
            })
      ])),
    );
  }
}
