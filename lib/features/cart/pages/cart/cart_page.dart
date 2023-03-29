import 'package:flutter/material.dart';
import 'package:flutter_menu/core/routes/app_routes.dart';
import 'package:flutter_menu/core/utils/utils_services.dart';
import 'package:flutter_menu/core/widgets/core_back_button.dart';
import 'package:flutter_menu/core/widgets/core_dialog_widget.dart';
import 'package:flutter_menu/core/widgets/core_elevated_button.dart';
import 'package:flutter_menu/core/widgets/core_page_title.dart';
import 'package:flutter_menu/features/cart/controllers/cart_controller.dart';
import 'package:flutter_menu/features/cart/pages/cart/cart_page_actions.dart';
import 'package:flutter_menu/features/cart/pages/cart/widgets/cart_item.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> implements CartPageActions {
  final CartController controller = Get.find();
  final UtilServices utilServices = UtilServices();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.only(top: 24, bottom: 90),
              children: [
                Row(
                  children: const [
                    SizedBox(width: 24),
                    CoreBackButton(),
                    Expanded(child: CorePageTitle(title: 'Carrinho')),
                  ],
                ),
                const SizedBox(height: 32),
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 24, right: 16),
                  itemCount: controller.productCount,
                  itemBuilder: (_, i) {
                    final product = controller.products[i];
                    return CartItem(
                      product: product,
                    );
                  },
                ),
              ],
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: CoreElevatedButton(
                title:
                    'Finalizar por ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(controller.totalPrice)}',
                onPressed: controller.products.isNotEmpty
                    ? () {
                        if (controller.isCheckoutValid) {
                          ShowUserInfoDialog().showUserInfoDialog(context);
                        } else {
                          utilServices.showToast(
                              message:
                                  'Adicione no mínimo 30 itens no seu carrinho para continuar');
                        }
                      }
                    : null,
              ),
            )
          ],
        ),
      );
    });
  }

  @override
  void goToHome() {
    Get.toNamed(AppRoutes.menu.path);
  }

  @override
  void initState() {
    super.initState();
    controller.setActions(this);
  }

  @override
  void dispose() {
    controller.setActions(null);
    super.dispose();
  }

  @override
  void showErrorMessage() {
    utilServices.showToast(message: 'Erro ao fazer pedido', isError: true);
  }

  @override
  void showSuccessMessage() {
    utilServices.showToast(
      message: 'Pedido feito com sucesso',
      onTap: () => Get.offAndToNamed(AppRoutes.cart.path),
    );
  }

  @override
  void goToPayment() {
    Get.toNamed(AppRoutes.checkout.path);
  }
}
