import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';
import 'package:flutter_menu/features/checkout/model/credit_model.dart';
import 'package:flutter_menu/features/checkout/widget/card_back.dart';
import 'package:flutter_menu/features/checkout/widget/card_front_widget.dart';

class CreditCardWidget extends StatefulWidget {
  final CreditCardModel? creditCard;
  const CreditCardWidget({super.key, this.creditCard});

  @override
  State<CreditCardWidget> createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  final FocusNode numberFocus = FocusNode();

  final FocusNode dateFocus = FocusNode();

  final FocusNode nameFocus = FocusNode();

  final FocusNode cvvFocus = FocusNode();

  // CreditCard? creditCard;

  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 0,
        left: 32,
        right: 32,
        top: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FlipCard(
            key: cardKey,
            front: CardFront(
              creditCard: widget.creditCard,
              numberFocus: numberFocus,
              dateFocus: dateFocus,
              nameFocus: nameFocus,
              finishedFront: () {
                cardKey.currentState!.toggleCard();
                cvvFocus.requestFocus();
              },
            ),
            back: CardBack(
              creditCard: widget.creditCard,
              cvvFocus: cvvFocus,
            ),
            direction: FlipDirection.HORIZONTAL,
            speed: 700,
            flipOnTouch: false,
          ),
          TextButton(
            onPressed: () {
              cardKey.currentState!.toggleCard();
            },
            child: const Text(
              'Virar Cartão',
              style: TextStyle(
                color: ColorsTheme.kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
