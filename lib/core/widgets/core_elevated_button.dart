import 'package:flutter/material.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';

class CoreElevatedButton extends StatelessWidget {
  const CoreElevatedButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
    this.color,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String title;
  final EdgeInsets padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? ColorsTheme.kPrimaryColor,
        disabledBackgroundColor: ColorsTheme.kPrimaryColor.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: padding,
      ),
      child: Text(
        title,
      ),
    );
  }
}
