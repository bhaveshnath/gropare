import 'package:flutter/foundation.dart';
import 'package:gropare/models/category.dart' as model;
import 'package:gropare/service/category.dart';

class CategoryProvider with ChangeNotifier {
  CategoryService categoryService = CategoryService();

  model.Category category;

  CategoryProvider.initialize() {
    /*loadCategory();*/
  }

  /* loadCategory() async {
    categoris = CategoryService().getCategories();
    notifyListeners();
  }*/

  loadSingleCategory(String cid) async {
    category = await CategoryService().getCategorybyid(cid);
    notifyListeners();
  }
}
