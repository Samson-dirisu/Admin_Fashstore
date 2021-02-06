import 'dart:io';

import 'package:admin_fashstore/widget/outline_button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_fashstore/db/brand.dart';
import 'package:admin_fashstore/db/category.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:admin_fashstore/db/product.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory = '';
  String _currentBrand = '';
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  ProductService _productService = ProductService();
  List<String> selectedSizes = <String>[];
  ImagePicker imagePicker;
  File _image1;
  File _image2;
  File _image3;
  File temp;
  bool isLoading = false;

  @override
  void initState() {
    getCategories();
    getBrands();
    super.initState();
  }

  List<DropdownMenuItem<String>> getCategoriesDropdown() {
    List<DropdownMenuItem<String>> items = List();
    for (int i = 0; i < categories.length; i++) {
      setState(
        () {
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

  List<DropdownMenuItem<String>> getBrandDropdown() {
    List<DropdownMenuItem<String>> items = List();
    for (int i = 0; i < brands.length; i++) {
      items.insert(
        0,
        DropdownMenuItem(
          child: Text(brands[i].data()['brand']),
          value: brands[i].data()['brand'],
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0.7,
        title: Text(
          "add product",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomOutlineButton(
                          child: displayImage(
                            _image1,
                          ),
                          onPressed: () {
                            _selectImage(1);
                          },
                        ),
                      ),
                      Expanded(
                        child: CustomOutlineButton(
                          child: displayImage(_image2),
                          onPressed: () {
                            _selectImage(2);
                          },
                        ),
                      ),
                      Expanded(
                        child: CustomOutlineButton(
                          child: displayImage(_image3),
                          onPressed: () {
                            _selectImage(3);
                          },
                        ),
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
                        String returnedValue =
                            "You must enter the product name";
                        return returnedValue;
                      } else if (value.length > 10) {
                        return "Product name can't have more than 10 letters";
                      } else
                        return null;
                    },
                  ),

                  // SELECT CATEGORY
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Category",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, top: 8.0),
                            child: DropdownButton(
                                items: categoriesDropDown,
                                onChanged: changeSelectionCategory,
                                value: _currentCategory),
                          ),
                        ],
                      ),
                      // Select brand
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Brand",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 0.0),
                            child: DropdownButton(
                                items: brandDropDown,
                                onChanged: changeSelectionBrand,
                                value: _currentBrand),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // QUANTITY FIELD
                  TextFormField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    //  initialValue: '1' ,
                    decoration: InputDecoration(
                      hintText: "Quantity",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        String returnedValue =
                            "You must enter quantity of product";
                        return returnedValue;
                      } else
                        return null;
                    },
                  ),

                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    // initialValue: '0.00' ,
                    decoration: InputDecoration(
                      hintText: "Price",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        String returnedValue =
                            "You must enter price of product";
                        return returnedValue;
                      } else
                        return null;
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 0.0),
                    child: Center(
                      child: Text(
                        'Available sizes',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // CHECKBOX
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          value: selectedSizes.contains('XS'),
                          onChanged: (value) => changeSelectedSize('XS')),
                      Text('XS'),
                      Checkbox(
                          value: selectedSizes.contains('S'),
                          onChanged: (value) => changeSelectedSize('S')),
                      Text('S'),
                      Checkbox(
                          value: selectedSizes.contains('M'),
                          onChanged: (value) => changeSelectedSize('M')),
                      Text('M'),
                      Checkbox(
                          value: selectedSizes.contains('L'),
                          onChanged: (value) => changeSelectedSize('L')),
                      Text('L'),
                      Checkbox(
                          value: selectedSizes.contains('XL'),
                          onChanged: (value) => changeSelectedSize('XL')),
                      Text('XL'),
                    ],
                  ),

                  Row(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          value: selectedSizes.contains('30'),
                          onChanged: (value) => changeSelectedSize('30')),
                      Text('30'),
                      Checkbox(
                          value: selectedSizes.contains('32'),
                          onChanged: (value) => changeSelectedSize('32')),
                      Text('32'),
                      Checkbox(
                          value: selectedSizes.contains('34'),
                          onChanged: (value) => changeSelectedSize('34')),
                      Text('34'),
                      Checkbox(
                          value: selectedSizes.contains('36'),
                          onChanged: (value) => changeSelectedSize('36')),
                      Text('36'),
                      Checkbox(
                          value: selectedSizes.contains('38'),
                          onChanged: (value) => changeSelectedSize('38')),
                      Text('38'),
                    ],
                  ),

                  Row(
                    textDirection: TextDirection.ltr,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          value: selectedSizes.contains('40'),
                          onChanged: (value) => changeSelectedSize('40')),
                      Text('40'),
                      Checkbox(
                          value: selectedSizes.contains('42'),
                          onChanged: (value) => changeSelectedSize('42')),
                      Text('42'),
                      Checkbox(
                          value: selectedSizes.contains('44'),
                          onChanged: (value) => changeSelectedSize('44')),
                      Text('44'),
                      Checkbox(
                          value: selectedSizes.contains('46'),
                          onChanged: (value) => changeSelectedSize('46')),
                      Text('46'),
                      Checkbox(
                          value: selectedSizes.contains('48'),
                          onChanged: (value) => changeSelectedSize('48')),
                      Text('48'),
                    ],
                  ),

                  Center(
                    child: FlatButton(
                      onPressed: () {
                        validateUpload();
                      },
                      textColor: Colors.white,
                      color: Colors.pink,
                      child: Text("Add Product"),
                    ),
                  ),
                ],
              ),
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

  getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    setState(() {
      brands = data;
      _currentBrand = data[0].data()['brand'];
      brandDropDown = getBrandDropdown();
    });
  }

  changeSelectionBrand(String selectedBrand) {
    setState(() {
      _currentBrand = selectedBrand;
    });
  }

  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.add(size);
      });
    }
  }

  Future _selectImage(int number) async {
    ImagePicker imagePicker = ImagePicker();
    File tempImage;

    final pickedImage = await imagePicker.getImage(source: ImageSource.gallery);
    pickedImage == null
        ? print("select image")
        : tempImage = File(pickedImage.path);

    switch (number) {
      case 1:
        {
          setState(() {
            _image1 = tempImage;
          });
        }
        break;

      case 2:
        {
          setState(() {
            _image2 = tempImage;
          });
        }
        break;

      case 3:
        {
          setState(() {
            _image3 = tempImage;
          });
        }
        break;
      default:
    }
  }

  Widget displayImage(File image) {
    if (image == null) {
      return Icon(
        Icons.add,
      );
    }
    return Image.file(image, fit: BoxFit.cover);
  }

  void validateUpload() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      if (_image1 != null && _image2 != null && _image3 != null) {
        if (selectedSizes.isNotEmpty) {
          String imageUrl1;
          String imageUrl2;
          String imageUrl3;
          final FirebaseStorage storage = FirebaseStorage.instance;
          final String picture1 =
              '${DateTime.now().millisecond.toString()}.jpg';
          Reference ref1 = storage.ref().child(picture1);
          UploadTask task1 = ref1.putFile(_image1);

          final String picture2 =
              '${DateTime.now().millisecond.toString()}.jpg';
          Reference ref2 = storage.ref().child(picture2);
          UploadTask task2 = ref2.putFile(_image2);

          final String picture3 =
              '${DateTime.now().millisecond.toString()}.jpg';
          Reference ref3 = storage.ref().child(picture3);
          UploadTask task3 = ref3.putFile(_image3);

          TaskSnapshot snapshot1 = await task1.then((snapshot) => snapshot);
          TaskSnapshot snapshot2 = await task2.then((snapshot) => snapshot);

          task3.then(
            (snapshot3) async {
              imageUrl1 = await snapshot1.ref.getDownloadURL();
              imageUrl2 = await snapshot2.ref.getDownloadURL();
              imageUrl3 = await snapshot3.ref.getDownloadURL();
              List<String> imageList = [imageUrl1, imageUrl2, imageUrl3];

              _productService.uploadProduct(
                productName: _productNameController.text,
                price: double.parse(_priceController.text),
                sizes: selectedSizes,
                images: imageList,
                quantity: int.parse(_quantityController.text),
              );
              _formKey.currentState.reset();
              setState(() {
                isLoading = false;
              });
              Fluttertoast.showToast(msg: "product added successfully");
              Navigator.pop(context);
            },
          );
        } else {
          Fluttertoast.showToast(msg: "select atleast one size");
          setState(() {
            isLoading = false;
          });
        }
      } else {
        Fluttertoast.showToast(msg: "all the images must be provided");
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}

//  Padding(
//           padding: const EdgeInsets.fromLTRB(14, 60, 14, 60),
//           child: Image.file(image));
