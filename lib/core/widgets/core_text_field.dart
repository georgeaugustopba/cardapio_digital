import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';

class CoreTextField extends StatelessWidget {
  const CoreTextField({
    Key? key,
    required this.title,
    required this.hint,
    this.textInputType,
    this.formatters,
    required this.onChanged,
    this.initialValue,
    this.obscure = false,
    this.color = ColorsTheme.kBackgroundColor,
    this.textColor,
  }) : super(key: key);

  final String? initialValue;
  final String title;
  final String hint;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? formatters;
  final Function(String) onChanged;
  final bool obscure;
  final Color color;
  final TextStyle? textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(24),
          ),
          child: TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              isCollapsed: true,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),
              hintText: hint,
              hintStyle: textColor,
            ),
            style: const TextStyle(
              color: Colors.white,
            ),
            keyboardType: textInputType,
            inputFormatters: formatters,
            onChanged: onChanged,
            obscureText: obscure,
          ),
        )
      ],
    );
  }
}
