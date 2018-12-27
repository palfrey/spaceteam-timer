import 'package:flutter/material.dart';
import 'difficulty.dart';
import 'timer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:url_launcher/url_launcher.dart';

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
        title: Text('Unoffical Spaceteam card game timer'),
      ),
      body: Row(children: <Widget>[
        Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    'Select difficulty',
                    maxLines: 1,
                    style: TextStyle(fontSize: 120.0),
                  )),
              RaisedButton(
                  child: AutoSizeText('\u{A0}Easy (7 minutes)\u{A0}',
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
                  child: AutoSizeText('\u{A0}Hard (3 minutes)\u{A0}',
                      maxLines: 1, style: TextStyle(fontSize: 120.0)),
                  onPressed: () {
                    selectDifficulty(context, Difficulty.Hard);
                  }),
              RaisedButton(
                  color: Color.fromRGBO(0x12, 0x1b, 0x2f, 1),
                  child: AutoSizeText('Buy the card game',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 120.0,
                          color: Color.fromRGBO(255, 255, 255, 1))),
                  onPressed: () {
                    launch("https://www.playspaceteam.com/store/");
                  }),
            ]))
      ]),
    );
  }
}
