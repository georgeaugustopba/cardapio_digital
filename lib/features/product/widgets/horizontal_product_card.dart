import 'package:flutter/material.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';
import 'package:flutter_menu/features/product/models/product.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard({Key? key, required this.product})
      : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: ColorsTheme.kBackgroundColor,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Get.toNamed('/products/${product.id}');
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(
                  product.imageUrl,
                ),
                radius: 40,
                backgroundColor: ColorsTheme.kSecondaryColor,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        color: ColorsTheme.kTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 36,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          product.description,
                          maxLines: 2,
                          style: TextStyle(
                            color: ColorsTheme.kTextColor.withOpacity(0.7),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          NumberFormat.simpleCurrency(locale: 'pt_BR')
                              .format(product.basePrice),
                          style: const TextStyle(
                            color: ColorsTheme.kPrimaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (product.originalBasePrice != null) ...[
                          const SizedBox(width: 2),
                          Text(
                            NumberFormat.simpleCurrency(locale: 'pt_BR')
                                .format(product.originalBasePrice),
                            style: const TextStyle(
                              color: Color(0xff5f6066),
                              fontSize: 9,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
