import 'package:flutter/material.dart';
import 'package:mytimer/widgets/SettingButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPreferences prefs;
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  int workTime, shortBreak, longBreak;
  TextEditingController textWork;
  TextEditingController textShort;
  TextEditingController textLong;

  @override
  void initState() {
    textWork = TextEditingController();
    textShort = TextEditingController();
    textLong = TextEditingController();
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 24);
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        childAspectRatio: 3,
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          Text(
            'Work',
            style: textStyle,
          ),
          Text(''),
          Text(''),
          SettingButton(
            color: Color(0xff455A64),
            text: '-',
            value: -1,
            setting: WORKTIME,
            callback: updateSettings,
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: textWork,
          ),
          SettingButton(
            color: Color(0xff009688),
            text: '+',
            value: 1,
            setting: WORKTIME,
            callback: updateSettings,
          ),
          Text(
            'Short',
            style: textStyle,
          ),
          Text(''),
          Text(''),
          SettingButton(
            color: Color(0xff455A64),
            text: '-',
            value: -1,
            setting: SHORTBREAK,
            callback: updateSettings,
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: textShort,
          ),
          SettingButton(
            color: Color(0xff009688),
            text: '+',
            value: 1,
            setting: SHORTBREAK,
            callback: updateSettings,
          ),
          Text(
            'Long',
            style: textStyle,
          ),
          Text(''),
          Text(''),
          SettingButton(
            color: Color(0xff455A64),
            text: '-',
            value: -1,
            setting: LONGBREAK,
            callback: updateSettings,
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: textLong,
          ),
          SettingButton(
            color: Color(0xff009688),
            text: '+',
            value: 1,
            setting: LONGBREAK,
            callback: updateSettings,
          ),
        ],
        padding: EdgeInsets.all(20.0),
      ),
    );
  }

  void readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int workTime = prefs.getInt(WORKTIME);
    if (workTime == null) await prefs.setInt(WORKTIME, int.parse('30'));
    int shortBreak = prefs.getInt(SHORTBREAK);
    if (shortBreak == null) await prefs.setInt(SHORTBREAK, int.parse('3'));
    int longBreak = prefs.getInt(LONGBREAK);
    if (longBreak == null) await prefs.setInt(LONGBREAK, int.parse('20'));
    setState(() {
      textWork.text = workTime?.toString();
      textShort.text = shortBreak?.toString();
      textLong.text = longBreak?.toString();
    });
  }

  void updateSettings(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int workTime = prefs.getInt(WORKTIME);
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              textWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int shortBreak = prefs.getInt(SHORTBREAK);
          shortBreak += value;
          if (shortBreak >= 1 && shortBreak <= 120) {
            prefs.setInt(SHORTBREAK, shortBreak);
            setState(() {
              textShort.text = shortBreak.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int longBreak = prefs.getInt(LONGBREAK);
          longBreak += value;
          if (longBreak >= 1 && longBreak <= 180) {
            prefs.setInt(LONGBREAK, longBreak);
            setState(() {
              textLong.text = longBreak.toString();
            });
          }
        }
        break;
    }
  }
}
