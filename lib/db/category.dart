import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String ref = "categories";

  void createCategory(String name) {
    var id = Uuid();
    String categoryId = id.v1();
    _firebaseFirestore
        .collection(ref)
        .doc(categoryId)
        .set({"category": name});
  }

  Future <List<DocumentSnapshot>> getCategories()  {
    return _firebaseFirestore.collection(ref).get().then((snaps) {
      return snaps.docs;
    });
  }

  Future getSuggestions(String suggestion) => _firebaseFirestore
      .collection(ref)
      .where("category", isEqualTo: suggestion)
      .get()
      .then((snap) => snap.docs);
}
