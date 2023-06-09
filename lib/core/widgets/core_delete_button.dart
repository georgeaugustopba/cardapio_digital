import 'package:flutter/material.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';

class CoreDeleteButton extends StatelessWidget {
  const CoreDeleteButton({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: Material(
        color: Colors.white.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: const Icon(
            Icons.close,
            color: ColorsTheme.kPrimaryColor,
            size: 16,
          ),
        ),
      ),
    );
  }
}
