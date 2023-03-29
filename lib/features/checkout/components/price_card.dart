import 'package:flutter/material.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';
import 'package:flutter_menu/features/cart/controllers/cart_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({Key? key}) : super(key: key);
  //final String? buttonText;
  //final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Resumo do Pedido',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ColorsTheme.kPrimaryColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Subtotal',
                    ),
                    Text(
                      NumberFormat.simpleCurrency(locale: 'pt-BR').format(
                        cartController.totalPrice,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                //     if (deliveryPrice != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text('Entrega'),
                    Text(
                      'Gratuita',
                    )
                  ],
                ),
                const Divider(),

                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      'Total: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: ColorsTheme.kPrimaryColor,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      NumberFormat.simpleCurrency(locale: 'pt-BR').format(
                        cartController.totalPrice,
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: ColorsTheme.kPrimaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          )),
    );
  }
}
