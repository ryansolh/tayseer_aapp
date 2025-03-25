import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_apps/core/component/my_custom_shadermask.dart';

void showCustomSnackbar({
  required String title,
  required String subTitle,
  Color backgroundColor = const Color(0xFF81A7D6),
  Color textColor = const Color(0xFFE0DADA),
}) {
  if(backgroundColor == const Color(0xFF81A7D6)){
    Get.snackbar(
      "", "",
      titleText: MyShaderMask(toolWidget: Text(
        title,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ), radius: 0),
      messageText: Text(
        subTitle,
        textDirection: TextDirection.rtl,
        style: TextStyle(color: textColor),
      ),

      colorText: Colors.white,
    );
  }
  else{
    Get.snackbar(
      backgroundColor: backgroundColor,
      "", "",
      titleText: Text(
        title,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      messageText: Text(
        subTitle,
        textDirection: TextDirection.rtl,
        style: TextStyle(color: Colors.white),
      ),

      colorText: Colors.white,
    );
  }

}
