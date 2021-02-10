import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:gropare/models/category.dart';

class CategoryService {
  String collection = "categories";
  List<Category> categories = [];
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<Category>> getCategories() {
    return _firebaseFirestore
        .collection(collection)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        categories.add(Category.fromSnapshot(element));
      });
      return categories;
    });
  }

  Future<Category> getCategorybyid(String id) =>
      _firebaseFirestore.collection(collection).doc(id).get().then((doc) {
        return Category.fromSnapshot(doc);
      });
}
