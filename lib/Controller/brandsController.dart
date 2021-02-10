import 'package:get/get.dart';
import 'package:gropare/models/brands.dart';
import 'package:gropare/service/brands.dart';

class BrandsController extends GetxController {
  var brands = List<Brands>().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchBrands();
  }

  void fetchBrands() async {
    await Future.delayed(Duration(seconds: 2));
    brands.value = await BrandService().getBrands();
  }
}
