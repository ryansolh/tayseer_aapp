import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar({
  required String title,
  required String subTitle,
  Color backgroundColor = const Color(0xFF81A7D6),
  Color textColor = const Color(0xFFE0DADA),
}) {
  Get.snackbar(
    "", "",
    titleText: Text(
      title,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
    ),
    messageText: Text(
      subTitle,
      textDirection: TextDirection.rtl,
      style: TextStyle(color: textColor),
    ),

    colorText: Colors.white,
  );
}
