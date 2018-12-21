import 'package:flutter/material.dart';
import 'choose.dart';
import 'setup.dart';

void main() {
  setupMusicFiles();
  runApp(MaterialApp(
    title: 'Spaceteam Timer',
    home: TimerSelect(),
  ));
}
