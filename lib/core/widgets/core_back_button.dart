import 'package:flutter/material.dart';
import 'package:flutter_menu/core/routes/app_routes.dart';
import 'package:get/get.dart';

class CoreBackButton extends StatelessWidget {
  const CoreBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xff393c44),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Get.routing.isBack == true
            ? Get.back(canPop: true)
            : Get.toNamed(AppRoutes.menu.path),
        child: const SizedBox(
          width: 42,
          height: 42,
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }
}
