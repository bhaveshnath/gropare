import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gropare/Controller/cart_controller.dart';
import 'package:gropare/models/cart_model.dart';
import 'package:gropare/models/product.dart';
import 'package:uuid/uuid.dart';

class CartService {
  Cart cartmodel;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<Cart> cartitems = [];
  Future<bool> addTocart(Product product, int quantity) async {
    try {
      var uuid = Uuid();
      String cartItemid = uuid.v4();

      bool itemExist = false;

      Map cartItem = {
        "id": cartItemid,
        "name": product.name,
        "image": product.image,
        "price": product.price,
        "productid": product.id,
        "quantity": quantity,
        "unit": product.unit
      };

      Cart item = Cart.fromMap(cartItem);
      if (!itemExist) {
        CartController().addToCart(item);
        return true;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<List<Cart>> getCartproducts() {
    var query = _firebaseFirestore.collection("cart").doc("bhavesh123");

    return query.snapshots().map((event) {
      List<Map<dynamic, dynamic>> values = List.from(event.data()["cartitems"]);

      print(values);

      /* for (var i = 0; i < values.length; i++) {
        cartitems.add(Cart.fromMap(values[i]));
        print(cartitems[i].name);
        cartitems.toSet().toList();
      }*/
      return cartitems;
    });
  }

  Stream<List<Cart>> cartProducts() {
    return _firebaseFirestore
        .collection("carts")
        .doc("bhavesh123")
        .collection("products")
        .snapshots()
        .map((QuerySnapshot query) {
      query.docs.forEach((element) {
        cartitems.add(Cart.fromSnapShots(element));

        print(cartitems);
      });
      cartitems.toSet().toList();

      return cartitems;
    });
  }

  /* Stream<List<Cart>> todo() {
    return _firebaseFirestore
        .collection("cart")
        .snapshots()
        .map((QuerySnapshot query) {
      query.docs.forEach((element) {
        List<Map<String, dynamic>> values =
            List.from(element.data()["cartitems"]);

        if (values.length != null) {
          for (var i = 0; i < values.length; i++) {
            cartitems.add(Cart.fromMap(values[i]));

            print(cartitems[i].name);
          }
        }
      });
      return cartitems;
    });*/

  StreamSubscription<DocumentSnapshot> getCartproducts1() {
    var query = _firebaseFirestore.collection("cart").doc("bhavesh123");

    return query.snapshots().listen((event) {
      List<Map<String, dynamic>> values = List.from(event.data()["cartitems"]);
      print(values);
      for (var i = 0; i < values.length; i++) {
        cartitems.add(Cart.fromMap(values[i]));
        print(cartitems[i].name);
      }
      return cartitems as Stream<List<Cart>>;
    });
  }
}

/*var query = _firebaseFirestore.collection("cart").doc("bhavesh123");

    query.snapshots().forEach((element) {
      List<Map<String, dynamic>> values =
          List.from(element.data()["cartitems"]);
      print(values);
      for (var i = 0; i < values.length; i++) {
        cartitems.add(Cart.fromMap(values[i]));
        print(cartitems[i].name);
      }
      print(cartitems.length);
    });
    return cartitems as Stream;*/
