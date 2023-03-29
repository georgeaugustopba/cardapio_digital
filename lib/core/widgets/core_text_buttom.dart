import 'package:flutter/material.dart';

class CoreTextButtom extends StatelessWidget {
  const CoreTextButtom(
      {super.key,
      required this.ontap,
      required this.title,
      required this.color});

  final VoidCallback ontap;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      color: Colors.transparent,
      child: InkWell(
        onTap: ontap,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
