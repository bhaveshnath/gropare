import 'package:flutter/cupertino.dart';
import 'package:gropare/models/product.dart';
import 'package:gropare/service/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> products = [];
  ProductProvider.initialize() {
    loadProducts();
  }

  loadProducts() async {
    products = await ProductService().getproducts();
    notifyListeners();
  }
}
