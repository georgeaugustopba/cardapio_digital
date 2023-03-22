import 'package:flutter/material.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';
import 'package:flutter_menu/core/widgets/core_delete_button.dart';
import 'package:flutter_menu/features/cart/controllers/cart_controller.dart';
import 'package:flutter_menu/features/product/models/product.dart';
import 'package:get/get.dart';

class CartItemSummary extends StatelessWidget {
  const CartItemSummary({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 78,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  radius: 34,
                  backgroundImage: NetworkImage(product.imageUrl),
                ),
              ),
              Positioned(
                top: 0,
                right: 10,
                child: CoreDeleteButton(onTap: () {
                  Get.find<CartController>().removeProduct(product);
                }),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
          child: Text(
            product.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ColorsTheme.kTextColor,
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}
