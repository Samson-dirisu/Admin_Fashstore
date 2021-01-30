
import 'package:admin_fashstore/widget/tile.dart';
import 'package:flutter/material.dart';

class ManageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(height: 30.0);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
      child: Column(
        children: [
          CustomizeTiles(
            icon: Icons.add, 
            label: "Add product",
            onTap: (){},),
          space,
          CustomizeTiles(
            icon: Icons.list, 
            label: "Products list",
            onTap: (){},),
          space,
          CustomizeTiles(
            icon: Icons.category, 
            label: "Add category",
            onTap: (){},),
          space,
          CustomizeTiles(
            icon: Icons.list_alt, 
            label: "Category list",
            onTap: (){},),
          space,
          CustomizeTiles(
            icon: Icons.branding_watermark, 
            label: "Add brand",
            onTap: (){},),
          space,
          CustomizeTiles(
            icon: Icons.filter_list, 
            label: "Brand list",
            onTap: (){},),
        ],
      ),
    );
  }
}
