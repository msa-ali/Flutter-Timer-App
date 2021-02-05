import 'package:flutter/material.dart';
import 'package:mytimer/pages/TimerHomePage.dart';
import './timer.dart';

final double defaultPadding = 5.0;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final CountDownTimer timer = CountDownTimer();
  @override
  Widget build(BuildContext context) {
    timer.startWork();
    return MaterialApp(
      title: 'My Work Time',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: TimerHomePage(timer: timer),
    );
  }
}
