import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gropare/Controller/product_controller.dart';
import 'package:gropare/models/cart_model.dart';
import 'package:gropare/models/product.dart';
import 'package:gropare/service/cart_service.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  //var cartItems = List<Cart>().obs;
  Rx<List<Cart>> cartItems = Rx<List<Cart>>();

  var products = List<Product>().obs;
  List<Cart> get cartitems => cartItems.value;

  @override
  void onInit() {
    super.onInit();
    cartItems.bindStream(CartService().cartProducts());
  }

  void addtoCart(Cart cartItems) {
    FirebaseFirestore.instance.collection("carts").doc("bhavesh123").update({
      "cartitems": FieldValue.arrayUnion([cartItems.toMap()])
    });
  }

  void addToCart(Cart cartItems) {
    var uuid = Uuid();
    String cartItemid = uuid.v4();

    FirebaseFirestore.instance
        .collection("carts")
        .doc("bhavesh123")
        .collection("products")
        .doc(cartItems.productid)
        .set(cartItems.toMap());
  }

  void updateQuantity(int quantity, String index) {
    FirebaseFirestore.instance
        .collection("carts")
        .doc("bhavesh123")
        .collection("products")
        .doc(index)
        .update({'quantity': quantity}).then((value) {});
  }
}
