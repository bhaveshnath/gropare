import 'package:get/get.dart';
import 'package:gropare/models/category.dart';
import 'package:gropare/service/category.dart';

class CategoryController extends GetxController {
  var categories = List<Category>().obs;
  @override
  void onInit() {
    categories.bindStream(CategoryService().getCategories());
    super.onInit();
  }
}
