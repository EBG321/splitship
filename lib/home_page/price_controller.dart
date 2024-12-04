import 'package:get/get.dart';

class PriceController extends GetxController {
  var minPrice = 0.0.obs;
  var maxPrice = 200.0.obs;

  void updatePriceRange(double min, double max) {
    minPrice.value = min;
    maxPrice.value = max;
  }
}
