import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/material.dart';
import 'difficulty.dart';
import 'setup.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TimerScreen extends StatefulWidget {
  final Difficulty difficulty;

  TimerScreen({Key key, @required this.difficulty}) : super(key: key);

  _TimerState createState() => _TimerState();
}

class _TimerState extends State<TimerScreen> {
  bool _isPlaying = false;
  int startMs;
  int totalSeconds;
  String _playerTxt = "";
  FlutterSound flutterSound;

  String padLeft(int value) {
    return value.toString().padLeft(2, '0');
  }

  String timeFromSeconds(int seconds) {
    return "${padLeft((seconds / 60).floor())}:${padLeft(seconds % 60)}";
  }

  @override
  void initState() {
    super.initState();
    startMs = startForDifficulty(widget.difficulty);
    totalSeconds = lengthForDifficulty(widget.difficulty) * 60;
    this.flutterSound = new FlutterSound();
    pathForLength(lengthForDifficulty(widget.difficulty)).then((path) {
      return flutterSound.startPlayer('file://$path');
    }).then((result) {
      this.setState(() {
        this._isPlaying = true;
      });
      flutterSound.onPlayerStateChanged.listen((e) {
        if (!this.mounted) return;
        if (e != null) {
          if (e.currentPosition < startMs) {
            this.setState(() {
              this._playerTxt = "Get Ready!";
            });
          } else if (e.currentPosition > startMs + (totalSeconds * 1000)) {
            this.setState(() {
              this._playerTxt = "Failed!";
            });
          } else {
            DateTime date = new DateTime.fromMillisecondsSinceEpoch(
                e.currentPosition.toInt());
            DateTime sinceStart =
                date.subtract(new Duration(milliseconds: startMs));
            int secondsSoFar = (sinceStart.minute * 60) + sinceStart.second;
            String sinceTxt = timeFromSeconds(secondsSoFar);
            int remainingSeconds = totalSeconds - secondsSoFar;
            String endTxt = timeFromSeconds(remainingSeconds);
            this.setState(() {
              this._playerTxt = "Used: $sinceTxt\nRemaining: $endTxt";
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Run timer'),
        ),
        body: Row(children: <Widget>[
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                AutoSizeText(_playerTxt,
                    style: TextStyle(fontSize: 120.0), maxLines: 2),
                RaisedButton(
                    child: AutoSizeText('Stop timer',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 120.0,
                            color: Color.fromRGBO(255, 255, 255, 1))),
                    color: Color.fromRGBO(255, 0, 0, 1),
                    onPressed: () {
                      this.flutterSound.stopPlayer().then((v) {
                        this.setState(() {
                          this._isPlaying = false;
                        });
                      });
                    })
              ]))
        ]));
  }

  @override
  void deactivate() {
    if (this._isPlaying) {
      this.flutterSound.stopPlayer();
    }
    super.deactivate();
  }
}
