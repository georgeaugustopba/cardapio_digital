import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';
import 'package:flutter_menu/features/checkout/model/credit_model.dart';
import 'package:flutter_menu/features/checkout/page/checkout_controller.dart';
import 'package:flutter_menu/features/checkout/widget/card_text_field.dart';
import 'package:get/get.dart';

class CardBack extends StatelessWidget {
  final FocusNode cvvFocus;
  final CreditCardModel? creditCard;

  const CardBack({Key? key, required this.cvvFocus, this.creditCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CheckoutController controller = Get.find();

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      elevation: 16,
      child: Container(
        height: 200,
        color: ColorsTheme.kSecondaryColor,
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 16),
            ),
            Row(
              children: [
                Expanded(
                  flex: 70,
                  child: Container(
                    //    height: 60,
                    color: Colors.grey[500],
                    margin: const EdgeInsets.only(left: 12),
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    child: CardTextField(
                      onChanged: controller.setCardCvv,
                      onSubmitted: (_) {},
                      focusNode: cvvFocus,
                      hint: '123',
                      maxLenght: 3,
                      inputFormaters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.end,
                      textInputType: TextInputType.number,
                      validator: (cvv) {
                        if (cvv!.length != 3) {
                          return 'Inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: Container(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
