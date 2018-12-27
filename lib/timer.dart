import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/material.dart';
import 'difficulty.dart';
import 'setup.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:screen/screen.dart';

class TimerScreen extends StatefulWidget {
  final Difficulty difficulty;

  TimerScreen({Key key, @required this.difficulty}) : super(key: key);

  _TimerState createState() => _TimerState();
}

class _TimerState extends State<TimerScreen> {
  bool isPlaying = false;
  bool success = false;
  int startMs;
  int totalSeconds;
  String playerTxt = "";
  FlutterSound flutterSound;
  String sinceTxt;
  String endTxt;

  String padLeft(int value) {
    return value.toString().padLeft(2, '0');
  }

  String timeFromSeconds(int seconds) {
    return "${padLeft((seconds / 60).floor())}:${padLeft(seconds % 60)}";
  }

  @override
  void initState() {
    super.initState();
    Screen.keepOn(true);
    startMs = startForDifficulty(widget.difficulty);
    totalSeconds = lengthForDifficulty(widget.difficulty) * 60;
    this.flutterSound = new FlutterSound();
    pathForLength(lengthForDifficulty(widget.difficulty)).then((path) {
      return flutterSound.startPlayer('file://$path');
    }).then((result) {
      this.setState(() {
        isPlaying = true;
        endTxt = timeFromSeconds(totalSeconds);
      });
      flutterSound.onPlayerStateChanged.listen((e) {
        if (!this.mounted) return;
        if (e != null) {
          if (e.currentPosition < startMs) {
            this.setState(() {
              playerTxt = "Get Ready!";
            });
          } else if (e.currentPosition > startMs + (totalSeconds * 1000)) {
            this.setState(() {
              playerTxt = "Mission Failure!";
              isPlaying = false;
            });
          } else {
            DateTime date = new DateTime.fromMillisecondsSinceEpoch(
                e.currentPosition.toInt());
            DateTime sinceStart =
                date.subtract(new Duration(milliseconds: startMs));
            int secondsSoFar = (sinceStart.minute * 60) + sinceStart.second;
            sinceTxt = timeFromSeconds(secondsSoFar);
            int remainingSeconds = totalSeconds - secondsSoFar;
            endTxt = timeFromSeconds(remainingSeconds);
            this.setState(() {
              playerTxt = "Used:\n$sinceTxt\nRemaining:\n$endTxt";
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      AutoSizeText(playerTxt,
          style: TextStyle(fontSize: 120.0), maxLines: success ? 3 : 4)
    ];
    if (isPlaying) {
      widgets.add(RaisedButton(
          child: AutoSizeText('Stop timer',
              maxLines: 1,
              style: TextStyle(
                  fontSize: 120.0, color: Color.fromRGBO(255, 255, 255, 1))),
          color: Color.fromRGBO(255, 0, 0, 1),
          onPressed: () {
            if (isPlaying) {
              flutterSound.stopPlayer().then((v) {
                setState(() {
                  success = true;
                  isPlaying = false;
                  playerTxt = "Success!\nRemaining:\n$endTxt";
                });
              });
            }
          }));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Play the game!'),
        ),
        body: Row(children: <Widget>[
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: widgets))
        ]));
  }

  @override
  void deactivate() {
    if (isPlaying) {
      this.flutterSound.stopPlayer();
    }
    Screen.keepOn(false);
    super.deactivate();
  }
}
