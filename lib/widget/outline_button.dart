import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final Function onPressed;
  CustomOutlineButton({@required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.grey, width: 2.0),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 40, 14, 40),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
