import 'package:dio/dio.dart';
import 'package:flutter_menu/core/utils/token_interception.dart';
import 'package:flutter_menu/features/auth/datasources/strapi_auth_datasource.dart';
import 'package:flutter_menu/features/auth/pages/auth/datasource/strapi_signup_datasource.dart';
import 'package:flutter_menu/features/auth/repositories/signup_repository.dart';
import 'package:flutter_menu/features/auth/repositories/auth_repository.dart';
import 'package:flutter_menu/features/cart/controllers/cart_controller.dart';
import 'package:flutter_menu/features/cart/repositories/cart_repository.dart';
import 'package:flutter_menu/features/checkout/page/checkout_controller.dart';
import 'package:flutter_menu/features/core/datasources/strapi_datasource.dart';
import 'package:flutter_menu/features/home/repositories/home_repository.dart';
import 'package:flutter_menu/features/order/repositories/order_repository.dart';
import 'package:get/get.dart';
//import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class CoreBindings implements Bindings {
  @override
  void dependencies() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:1337/api',
        headers: {
          'Authorization':
              'Bearer e3e138cf15a45aef7c6e287c6f41b0763f7dbe6e5bcd37481f6e10d767a70be2bbdc5eb9866cfd26e7f0ae8d6ce74437f39cd8e263e37dd321a1e34aed4e071af9f6f20ed8d5ab2b5bd8105bd1ae42f6c8c4c8eae937399418cdfcf845598ee7f634e16c062ba677e715801e7699354911f2b63ca8fe7b2108432bce979bb674'
        },
      ),
    );

    Get.put(dio);

    Get.lazyPut<StrapiDatasource>(() => StrapiDatasourceImpl(Get.find()));
    Get.lazyPut<StrapiAuthDatasource>(() => StrapiAuthDatasource(Get.find()));
    Get.lazyPut<StrapSignupDataSource>(() => StrapSignupDataSource(Get.find()));

    Get.lazyPut(() => CartRepository(Get.find()));
    Get.lazyPut(() => HomeRepository(Get.find()));
    Get.put(OrderRepository(Get.find()), permanent: true);
    Get.put(AuthRepository(Get.find()), permanent: true);
    Get.put(SignupRepository(Get.find()), permanent: true);

    Get.lazyPut(() => CartController());
    Get.lazyPut(() => CheckoutController());

    dio.interceptors.addAll([
      //  PrettyDioLogger(
      //    requestHeader: true,
      //    requestBody: true,
      //  ),
      TokenInterceptor(Get.find()),
    ]);
  }
}
