import 'package:flutter/material.dart';
import 'package:mytimer/main.dart';
import 'package:mytimer/models/timermodel.dart';
import 'package:mytimer/pages/settings.dart';
import 'package:mytimer/widgets/ProductivityButton.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../timer.dart';

class TimerHomePage extends StatelessWidget {
  final CountDownTimer timer;

  TimerHomePage({this.timer});

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = [];
    menuItems.add(
      PopupMenuItem(
        value: 'Settings',
        child: Text('Settings'),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Work Timer App',
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return menuItems.toList();
            },
            onSelected: (selectedOption) {
              if (selectedOption == 'Settings') {
                goToSettings(context);
              }
            },
          )
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final double availableWidth = constraints.maxWidth;
        return Column(
          children: [
            topActionButtons(),
            percentIndicator(availableWidth),
            bottomActionsButtons(),
          ],
        );
      }),
    );
  }

  Widget percentIndicator(double availableWidth) {
    return StreamBuilder(
        initialData: "00:00",
        stream: timer.stream(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          TimerModel myTimer = (snapshot.data == '00:00')
              ? TimerModel(time: '00:00', percent: 1)
              : snapshot.data;
          return Expanded(
            child: CircularPercentIndicator(
              radius: availableWidth / 2,
              lineWidth: 10.0,
              percent: myTimer.percent,
              center: Text(
                myTimer.time,
                style: Theme.of(context).textTheme.headline4,
              ),
              progressColor: Color(0xff009688),
              reverse: true,
            ),
          );
        });
  }

  Widget topActionButtons() {
    return Row(
      children: [
        Padding(padding: EdgeInsets.all(defaultPadding)),
        Expanded(
          child: ProductivityButton(
            color: Color(0xff009688),
            text: 'Work',
            onPressed: () => timer.startWork(),
          ),
        ),
        Padding(padding: EdgeInsets.all(defaultPadding)),
        Expanded(
          child: ProductivityButton(
            color: Color(0xff607D8B),
            text: 'Short Break',
            onPressed: () => timer.startBreak(true),
          ),
        ),
        Padding(padding: EdgeInsets.all(defaultPadding)),
        Expanded(
          child: ProductivityButton(
            color: Color(0xff455A64),
            text: 'Long Break',
            onPressed: () => timer.startBreak(false),
          ),
        ),
        Padding(padding: EdgeInsets.all(defaultPadding)),
      ],
    );
  }

  Widget bottomActionsButtons() {
    return Row(
      children: [
        Padding(padding: EdgeInsets.all(defaultPadding)),
        Expanded(
          child: ProductivityButton(
            color: Color(0xff212121),
            text: 'Stop',
            onPressed: () => timer.stopTimer(),
          ),
        ),
        Padding(padding: EdgeInsets.all(defaultPadding)),
        Expanded(
          child: ProductivityButton(
            color: Color(0xff009688),
            text: 'Restart',
            onPressed: () => timer.startTimer(),
          ),
        ),
        Padding(padding: EdgeInsets.all(defaultPadding)),
      ],
    );
  }

  void goToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsPage(),
      ),
    );
  }
}
