import 'package:flutter/material.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';

class ButtomHomeBottom extends StatelessWidget {
  const ButtomHomeBottom(
      {super.key,
      required this.page,
      required this.onChanged,
      required this.title,
      required this.icon});

  final int page;
  final Function(int) onChanged;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(24),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onChanged(1);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: ColorsTheme.kBackgroundColor,
                size: 24,
              ),
              const Text(
                'Catálogo ',
                style: TextStyle(
                  color: ColorsTheme.kBackgroundColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
