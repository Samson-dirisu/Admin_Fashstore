import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final Function onPressed;
  final Widget icon;
  final String label;

  TabButton({this.icon, this.label, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(label, style: TextStyle(fontWeight: FontWeight.bold),),
    );
  }
}
