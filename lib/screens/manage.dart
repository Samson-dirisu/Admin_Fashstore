import 'package:admin_fashstore/widget/tile.dart';
import 'package:flutter/material.dart';
import 'package:admin_fashstore/db/brand.dart';
import 'package:admin_fashstore/db/category.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'add_product.dart';

class ManageScreen extends StatefulWidget {
  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  TextEditingController categoryController = TextEditingController();

  TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();

  @override
  Widget build(BuildContext context) {
    Widget space = SizedBox(height: 30.0);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
        child: Column(
          children: [
            CustomizeTiles(
              icon: Icons.add,
              label: "Add product",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProduct(),
                  ),
                );
              },
            ),
            space,
            CustomizeTiles(
              icon: Icons.list,
              label: "Products list",
              onTap: () {},
            ),
            space,
            CustomizeTiles(
              icon: Icons.category,
              label: "Add category",
              onTap: () {
                _categoryAlert();
              },
            ),
            space,
            CustomizeTiles(
              icon: Icons.list_alt,
              label: "Category list",
              onTap: () {},
            ),
            space,
            CustomizeTiles(
              icon: Icons.branding_watermark,
              label: "Add brand",
              onTap: () {
                _brandAlert();
              },
            ),
            space,
            CustomizeTiles(
              icon: Icons.filter_list,
              label: "Brand list",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _categoryAlert() {
    var alert = AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: categoryController,
          decoration: InputDecoration(hintText: "add Category"),
          validator: (value) {
            if (value.isEmpty) {
              return "Category cannot be empty";
            }
            return null;
          },
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            var validate = _categoryFormKey.currentState;
            if (categoryController.text.isNotEmpty && validate.validate()) {
              _categoryService.createCategory(categoryController.text);
              Fluttertoast.showToast(msg: "category created sucessfully");
              Navigator.pop(context);
              categoryController.clear();
            }
          },
          child: Text("Add"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);

            categoryController.clear();
          },
          child: Text("Cancel"),
        ),
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }

  void _brandAlert() {
    var alert = AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: brandController,
          decoration: InputDecoration(hintText: "add Brand"),
          validator: (value) {
            if (value.isEmpty) {
              return "Brand cannot be empty";
            }
            return null;
          },
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            var validate = _brandFormKey.currentState;
            if (brandController.text.isNotEmpty && validate.validate()) {
              _brandService.createBrand(brandController.text);
              Fluttertoast.showToast(msg: "brand created successfully");
              Navigator.pop(context);
              brandController.clear();
            }
          },
          child: Text("Add"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
            brandController.clear();
          },
          child: Text("Cancel"),
        ),
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }
}
