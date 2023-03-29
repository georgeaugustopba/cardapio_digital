import 'package:flutter_menu/features/core/datasources/strapi_datasource.dart';
import 'package:flutter_menu/features/product/models/product.dart';
import 'package:flutter_menu/features/product/repositories/product_repository.dart';
import 'package:get/get.dart';

class ProductPageController extends GetxController {
  ProductPageController({
    required this.id,
    ProductRepository? productRepository,
  }) : productRepository = productRepository ?? Get.find();

  final int id;

  final ProductRepository productRepository;

  final Rxn<Product> product = Rxn<Product>();

  Future<void> getProduct() async {
    final result = await productRepository.getProduct(id);
    if (result.isRight) {
      product.value = result.right;
    } else {
      switch (result.left) {
        case GetProductError.unknownError:
          break;
        case GetProductError.notFound:
          break;
      }
    }
  }

  num? get total => product.value?.total;

  bool get isValid =>
      product.value != null && !product.value!.modifiers.any((m) => !m.isValid);
}
