import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void createCategory(String name) {
    var id = Uuid();
    String categoryId = id.v1();
    _firebaseFirestore
        .collection("category")
        .doc(categoryId)
        .set({"categoryname": name});
  }
}
