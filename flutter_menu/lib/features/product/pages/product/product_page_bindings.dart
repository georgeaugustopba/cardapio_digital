import 'package:flutter_menu/features/product/repositories/product_repository.dart';
import 'package:get/get.dart';

class ProductPageBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductRepository>(() => StrapiProductRepository(Get.find()));
  }
}