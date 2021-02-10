import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gropare/models/brands.dart';

class BrandService {
  String collection = "brands";
  List<Brands> brandss = [];
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List<Brands>> getBrands() async {
    await _firebaseFirestore
        .collection(collection)
        .snapshots()
        .listen((result) {
      result.docs.forEach((element) {
        brandss.add(Brands.fromSnapshot(element));
      });
    });
    return brandss;
  }
}
