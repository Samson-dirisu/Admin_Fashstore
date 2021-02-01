import 'package:admin_fashstore/widget/outline_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _productNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade300,
        elevation: 0.7,
        title: Text(
          "add product",
          style: TextStyle(color: Colors.white),
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
          Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: [
                Row(
                  children: [
                    CustomOutlineButton(
                      onPressed: () {},
                    ),
                    CustomOutlineButton(
                      onPressed: () {},
                    ),
                    CustomOutlineButton(
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  "Enter a product name with 10 characters",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                  ),
                ),
                TextFormField(
                  controller: _productNameController,
                  decoration: InputDecoration(
                    hintText: "Product name",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      String returnedValue = "You must enter the product name";
                      return returnedValue;
                    } else if (value.length > 10) {
                      return "Product name can't have more than 10 letters";
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
