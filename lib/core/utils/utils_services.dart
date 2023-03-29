import 'package:flutter/material.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UtilServices {
  Future<void> showToast(
      {required String message, bool isError = false, VoidCallback? onTap}) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: isError ? ColorsTheme.kPrimaryColor : Colors.white,
      textColor: isError ? Colors.white : Colors.black,
      fontSize: 14,
      webPosition: 'center',
      webShowClose: true,
      webBgColor:
          isError ? "linear-gradient(to right,#cb0162,#f7879a )" : "#caa53b",
    );
  }
}
