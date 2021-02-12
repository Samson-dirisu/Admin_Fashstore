import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String ref = "product";

  void uploadProduct({String productName, String brand, int quantity, String category, List sizes, List images, double price}) {
    var id = Uuid();
    String productId = id.v1();
    _firebaseFirestore
        .collection(ref)
        .doc(productId)
        .set({
          "name": productName,
          "brand" : brand,
          "category" : category,
          "id" : productId,

          });
  }


  

  
}
