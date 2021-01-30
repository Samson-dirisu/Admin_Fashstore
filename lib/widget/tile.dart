import 'package:flutter/material.dart';

class CustomizeTiles extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onTap;

  CustomizeTiles({@required this.icon, @required this.label, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
          child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
