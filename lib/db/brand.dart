import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String ref = "brand";

  void createBrand(String name) {
    var id = Uuid();
    String brandId = id.v1();
    _firebaseFirestore.collection(ref).doc(brandId).set({"brand": name});
  }

  Future<List<DocumentSnapshot>> getBrands() {
    return _firebaseFirestore.collection(ref).get().then((snaps) {
      return snaps.docs;
    });
  }

   Future getSuggestions(String suggestion) => _firebaseFirestore
      .collection(ref)
      .where("brand", isEqualTo: suggestion)
      .get()
      .then((snap) => snap.docs);

}
