import 'package:flutter/foundation.dart';
import 'package:gropare/models/brands.dart';
import 'package:gropare/service/brands.dart';

class BrandsProvider with ChangeNotifier {
  BrandService categoryService = BrandService();
  List<Brands> brands = [];
  BrandsProvider.initialize() {
    loadCategory();
  }

  loadCategory() async {
    Future.delayed(Duration(seconds: 2));
    brands = await BrandService().getBrands();
    notifyListeners();
  }
}
