
import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  CustomOutlineButton({@required this.onPressed, this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          //color: Colors.green,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          constraints: BoxConstraints.loose(Size.fromHeight(240)),
          width: 110,
          height: 120,
          child: child,
        ),
      ),
    );
  }
}
