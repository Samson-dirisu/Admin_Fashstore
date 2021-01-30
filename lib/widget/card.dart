import 'package:admin_fashstore/constants.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String label;
  final String total;
  final IconData icon;
  CustomCard({this.label, this.icon, this.total});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      //  clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: inactiveColor.withOpacity(0.7),
                ),
                Text(
                  "  " + label,
                  style: TextStyle(color: inactiveColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 12.0,
            ),
            child: Text(
              total,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 60.0,
                  color: activeColor,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
