import 'package:flutter/material.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';
import 'package:flutter_menu/features/product/models/modifiers/simple_modifier.dart';
import 'package:flutter_menu/features/product/pages/product/widgets/modifier_item_action.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SimpleModifierWidget extends StatelessWidget {
  const SimpleModifierWidget({super.key, required this.modifier});

  final SimpleModifier modifier;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return ListView(
          shrinkWrap: true,
          children: [
            for (final option in modifier.options)
              InkWell(
                onTap: modifier.canAddItem || modifier.contains(option)
                    ? () {
                        if (modifier.contains(option)) {
                          modifier.removeItem(option);
                        } else {
                          modifier.addItem(option);
                        }
                      }
                    : null,
                splashColor: Colors.white10,
                highlightColor: Colors.transparent,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              option.title,
                              style: const TextStyle(
                                color: ColorsTheme.kTextColorWite,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            if (option.price != null)
                              Text(
                                '+ ${NumberFormat.simpleCurrency(locale: 'pt_BR').format(option.price!)}',
                                style: const TextStyle(
                                  color: ColorsTheme.kPrimaryColor,
                                ),
                              )
                          ],
                        ),
                      ),
                      ModifierItemAction(
                        modifier: modifier,
                        item: option,
                      ),
                    ],
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
