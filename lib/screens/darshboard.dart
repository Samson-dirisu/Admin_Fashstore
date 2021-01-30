import 'package:admin_fashstore/constants.dart';
import 'package:admin_fashstore/screens/dashboard.dart';
import 'package:admin_fashstore/widget/tab_button.dart';
import 'package:flutter/material.dart';

import 'manage.dart';

enum Tab { dashboard, manage }

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  //VARIABLES
  Tab _page = Tab.dashboard;

  //
  Widget _pageViewer() {
    switch (_page) {
      case Tab.dashboard:
        {
          return Dashboard();
        }
        break;

      case Tab.manage:
        {
          return ManageScreen();
        }
        break;

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        elevation: 0.7,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TabButton(
              icon: Icon(Icons.dashboard,
                  color: _page == Tab.dashboard ? activeColor : inactiveColor),
              label: "Darshboard",
              onPressed: () {
                setState(() {
                  _page = Tab.dashboard;
                });
              },
            ),
            TabButton(
              icon: Icon(
                Icons.accessible,
                color: _page == Tab.manage ? activeColor : inactiveColor,
              ),
              label: "Manage",
              onPressed: () {
                setState(() {
                  _page = Tab.manage;
                });
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.pink,
                  Colors.pink.shade300,
                  Colors.pink.shade600
                ],
              ),
            ),
          ),
          _pageViewer(),
        ],
      ),
    );
  }
}
