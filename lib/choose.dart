import 'package:flutter/material.dart';
import 'difficulty.dart';
import 'timer.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
      body: Row(children: <Widget>[
        Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              AutoSizeText(
                'Select difficulty',
                maxLines: 1,
                style: TextStyle(fontSize: 120.0),
              ),
              RaisedButton(
                  child: AutoSizeText('Easy (7 minutes)',
                      maxLines: 1, style: TextStyle(fontSize: 120.0)),
                  onPressed: () {
                    selectDifficulty(context, Difficulty.Easy);
                  }),
              RaisedButton(
                  child: AutoSizeText('Medium (5 minutes)',
                      maxLines: 1, style: TextStyle(fontSize: 120.0)),
                  onPressed: () {
                    selectDifficulty(context, Difficulty.Medium);
                  }),
              RaisedButton(
                  child: AutoSizeText('Hard (3 minutes)',
                      maxLines: 1, style: TextStyle(fontSize: 120.0)),
                  onPressed: () {
                    selectDifficulty(context, Difficulty.Hard);
                  })
            ]))
      ]),
    );
  }
}
