import 'package:flutter/material.dart';
import 'package:flutter_menu/features/auth/pages/auth/auth_page.dart';
import 'package:flutter_menu/features/auth/repositories/auth_repository.dart';
import 'package:flutter_menu/features/cart/controllers/cart_controller.dart';
import 'package:flutter_menu/features/cart/pages/cart/cart_page.dart';
import 'package:flutter_menu/features/dashboard/pages/dashboard/dashboard_page.dart';
import 'package:flutter_menu/features/home/pages/home/home_page.dart';
import 'package:flutter_menu/features/order/models/order.dart';
import 'package:flutter_menu/features/product/pages/product/product_page.dart';
import 'package:flutter_menu/features/product/pages/product/product_page_bindings.dart';
import 'package:get/get.dart';

enum AppRoutes {
  menu('/menu'),
  //scan('/'),
  products('/products/:pid'),
  auth('/auth'),
  dashboard('/dashboard'),
  checkout('/checkout');

  const AppRoutes(this.path);

  final String path;
}

final appPages = [
  // GetPage(
  //   name: AppRoutes.scan.path,
  //   page: () => const ScanPage(),
  //   middlewares: [TestMiddleware()],
  // ),
  GetPage(
    name: AppRoutes.menu.path,
    page: () => HomePage(table: Get.parameters['table']),
    middlewares: [TestMiddleware()],
  ),
  GetPage(
    name: AppRoutes.products.path,
    page: () {
      final id = int.tryParse(Get.parameters['pid'] ?? '');
      return id == null ? Container() : ProductPage(id: id);
    },
    binding: ProductPageBindings(),
    middlewares: [TestMiddleware()],
  ),
  GetPage(
    name: AppRoutes.checkout.path,
    page: () => const CartPage(),
    middlewares: [TestMiddleware()],
  ),
  GetPage(name: AppRoutes.auth.path, page: () => AuthPage(), middlewares: [
    NotAuthenticatedMiddleware(),
  ]),
  GetPage(
      name: AppRoutes.dashboard.path,
      page: () => DashboardPage(
          status: Get.parameters['status'] != null
              ? OrderStatus.values.byName(Get.parameters['status']!)
              : null),
      middlewares: [
        AuthenticatedMiddleware(),
      ]),
];

class TestMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final CartController cartController = Get.find();
    if (route == AppRoutes.checkout.path && cartController.products.isEmpty) {
      return RouteSettings(name: AppRoutes.menu.path);
    }
    return null;
  }
}

//class TestMiddleware extends GetMiddleware {
//  @override
//  RouteSettings? redirect(String? route) {
//    final CartController cartController = Get.find();
//    if (route == AppRoutes.checkout.path && cartController.products.isEmpty) {
//      return RouteSettings(name: AppRoutes.menu.path);
//    } else if (route != AppRoutes.scan.path &&
//        cartController.table.value == null &&
//        !Get.parameters.containsKey('table')) {
//      return RouteSettings(name: AppRoutes.scan.path);
//    }
//    return null;
//  }
//}

class AuthenticatedMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final AuthRepository authRepository = Get.find();
    if (!authRepository.isLoggedIn) {
      return RouteSettings(name: AppRoutes.auth.path);
    }
    return null;
  }
}

class NotAuthenticatedMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final AuthRepository authRepository = Get.find();
    if (authRepository.isLoggedIn) {
      return RouteSettings(name: AppRoutes.dashboard.path);
    }
    return null;
  }
}



/*redirect: (context, state) {
final CartController cartController = context.read();
if(state.subloc == '/checkout' && cartController.products.isEmpty) {
return '/menu';
} else if(state.subloc != AppRoutes.scan.path && cartController.table == null && !state.queryParams.containsKey('table')) {
return AppRoutes.scan.path;
}
return null;
}*/
