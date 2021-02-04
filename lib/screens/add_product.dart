import 'package:admin_fashstore/widget/outline_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_fashstore/db/brand.dart';
import 'package:admin_fashstore/db/category.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _productNameController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory = '';
  String _currentBrand = '';
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();

  @override
  void initState() {
    getCategories();
    //getBrands();
    //_currentCategory = categoriesDropDown[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
          items.insert(
            0,
            DropdownMenuItem(
              child: Text(categories[i].data()['category']),
              value: categories[i]['category'],
            ),
          );
        },
      );
    }
    return items;
  }

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
                    } else
                      return null;
                  },
                ),

                // SELECT CATEGORY
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Text("Category", style: TextStyle(
                            color: Colors.white,
                          ),),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                            child: DropdownButton(
                              items:  categoriesDropDown,
                              onChanged: changeSelectionCategory,
                              value: _currentCategory
                            ),
                          ),
                         
                        ],
                      ),

                      FlatButton(
                        onPressed: () {},
                        textColor: Colors.white,
                        color: Colors.pink.shade100,
                        child: Text("Add Product"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

   getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    setState(() {
      categories = data;
      _currentCategory = categories[0].data()['category'];
      
    categoriesDropDown = getCategoriesDropdown();
    });
  }

  changeSelectionCategory(String selectedCategory) {
    setState(() {
      return _currentCategory = selectedCategory;
    });
  }
}
