import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/material.dart';
import 'difficulty.dart';
import 'setup.dart';
import 'package:intl/intl.dart';

class TimerScreen extends StatefulWidget {
  final Difficulty difficulty;

  TimerScreen({Key key, @required this.difficulty}) : super(key: key);

  _TimerState createState() => _TimerState();
}

class _TimerState extends State<TimerScreen> {
  bool _isPlaying = false;
  String _playerTxt = "";
  FlutterSound flutterSound;

  @override
  void initState() {
    super.initState();
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
          int startMs = startForDifficulty(widget.difficulty);
          if (e.currentPosition < startMs) {
            this.setState(() {
              this._playerTxt = "wait...";
            });
          } else {
            DateTime date = new DateTime.fromMillisecondsSinceEpoch(
                e.currentPosition.toInt());
            date = date.subtract(new Duration(milliseconds: startMs));
            String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
            this.setState(() {
              this._playerTxt = txt.substring(0, 8);
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
        body: Center(
            child: Column(children: <Widget>[
          Text(_playerTxt, style: TextStyle(fontSize: 48.0)),
          IconButton(
              icon: Icon(Icons.stop),
              iconSize: 128,
              tooltip: 'Stop',
              onPressed: () {
                this.flutterSound.stopPlayer().then((v) {
                  this.setState(() {
                    this._isPlaying = false;
                  });
                });
              })
        ])));
  }

  @override
  void deactivate() {
    if (this._isPlaying) {
      this.flutterSound.stopPlayer();
    }
    super.deactivate();
  }
}
