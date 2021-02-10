import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gropare/Controller/brandsController.dart';
import 'package:gropare/Controller/category_controller.dart';
import 'package:gropare/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  List<Product> products = [];
  List<Product> retval = List();
  List<Product> bycaegoryprod = [];

  String colllection = "products";
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List<Product>> getproducts() async {
    _firebaseFirestore.collection(colllection).get().then((result) {
      for (DocumentSnapshot produc in result.docs) {
        products.add(Product.fromSnapshot(produc));
      }
    });
    return products;
  }

  Future getproductBycat(String categoryName) async {
    return _firebaseFirestore
        .collection(colllection)
        .where("category", isEqualTo: categoryName)
        .get();
  }

  Stream getProdutsbyCategory(String categoryName) {
    return _firebaseFirestore
        .collection(colllection)
        .where("category", isEqualTo: categoryName)
        .snapshots();
  }
}
