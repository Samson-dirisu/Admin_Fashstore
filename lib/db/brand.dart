import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String ref = "brand";

  void createBrand(String name) {
    var id = Uuid();
    String brandId = id.v1();
    _firebaseFirestore.collection(ref).doc(brandId).set({"categoryname": name});
  }

  Future<List> getBrands() {
    Stream<QuerySnapshot> snapshots =
        _firebaseFirestore.collection(ref).snapshots();

    List brands;

    snapshots.forEach((snap) {
      brands.insert(0, snap.docs);
    });
  }
}
