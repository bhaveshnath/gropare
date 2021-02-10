import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gropare/Controller/category_controller.dart';
import 'package:gropare/models/category.dart';
import 'package:gropare/models/product.dart';
import 'package:gropare/service/product.dart';

class ProductController extends GetxController {
  int size = Get.find<CategoryController>().categories.length;

  var products = List<Product>().obs;
  var cbyproducts = List<Product>().obs;
  var quantity = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }

  void fetchProducts() async {
    products.value = await ProductService().getproducts();
  }
}
