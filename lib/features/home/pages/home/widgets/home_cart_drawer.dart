import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';
import 'package:flutter_menu/core/routes/app_routes.dart';
import 'package:flutter_menu/features/cart/controllers/cart_controller.dart';
import 'package:flutter_menu/features/cart/widgets/cart_item_summary.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeCartDrawer extends StatelessWidget {
  const HomeCartDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    return Obx(() {
      return SizedBox(
        width: 102,
        child: Drawer(
          child: Stack(
            children: [
              LiveList.options(
                options: const LiveOptions(
                  delay: Duration.zero,
                  showItemInterval: Duration(milliseconds: 50),
                  showItemDuration: Duration(milliseconds: 300),
                  reAnimateOnVisibility: false,
                  visibleFraction: 0.05,
                ),
                padding: EdgeInsets.only(
                  top: 102 + MediaQuery.of(context).viewPadding.top,
                  bottom: 160,
                ),
                itemBuilder: (_, i, anim) {
                  final product = cartController.products[i];

                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: const Offset(0, 0),
                    ).animate(anim),
                    child: CartItemSummary(
                      product: product,
                    ),
                  );
                },
                itemCount: cartController.productCount,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorsTheme.kBackgroundColor,
                        Colors.transparent,
                      ],
                      stops: [0.5, 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  height: 102 + MediaQuery.of(context).viewPadding.top,
                  width: 102,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 102,
                  height: 260,
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorsTheme.kBackgroundColor,
                        Colors.transparent,
                      ],
                      stops: [0.5, 1],
                      end: Alignment.topCenter,
                      begin: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${cartController.productCount} ${cartController.productCount == 1 ? 'item' : 'itens'}',
                        style: const TextStyle(
                          color: ColorsTheme.kTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 11,
                          color: ColorsTheme.kTextColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        NumberFormat.simpleCurrency(locale: 'pt_BR')
                            .format(cartController.totalPrice),
                        style: const TextStyle(
                          color: ColorsTheme.kPrimaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (cartController.productCount > 0) ...[
                        SizedBox(
                          width: 54,
                          height: 54,
                          child: Material(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27),
                            ),
                            color: ColorsTheme.kPrimaryColor,
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.checkout.path);
                              },
                              child: const Icon(
                                Icons.arrow_forward_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
