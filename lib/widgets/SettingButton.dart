import 'package:flutter/material.dart';

typedef CallbackSetting = void Function(String, int);

class SettingButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final int value;
  final String setting;
  final CallbackSetting callback;

  const SettingButton(
      {Key key,
      this.color,
      this.text,
      this.value,
      this.setting,
      this.callback,
      this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(this.text),
      textColor: Colors.white,
      onPressed: () => this.callback(this.setting, this.value),
      color: this.color,
      minWidth: this.size,
    );
  }
}
