import 'package:admin_fashstore/widget/card.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Revenue",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: inactiveColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("\$ 12,000",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w700,
                      fontSize: 25.0)),
            ),
          ),
          Expanded(
            child: Container(
              // height: 200,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 30.0,
                    childAspectRatio: 1),
                physics: NeverScrollableScrollPhysics(),
                children: [
                  CustomCard(
                      icon: Icons.person, label: "Users", total: "7"),
                  CustomCard(
                      icon: Icons.category, label: "Category", total: "23"),
                  CustomCard(
                      icon: Icons.forum, label: "Products", total: "120"),
                  CustomCard(
                      icon: Icons.emoji_emotions, label: "Sold", total: "13"),
                  CustomCard(
                      icon: Icons.shopping_cart, label: "Orders", total: "5"),
                  CustomCard(icon: Icons.cancel, label: "Return", total: "0"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
