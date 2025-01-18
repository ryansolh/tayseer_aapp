import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void confirmedSnakBarMessage(String title,String subTitle){
  Get.snackbar("", "",
    titleText:  Text("${title}",
        textDirection: TextDirection.rtl,
        style: TextStyle(color: Color(0xFFE0DADA),
            fontWeight: FontWeight.bold)
    ),
    messageText:Text("${subTitle}",
      textDirection: TextDirection.rtl,
      style: TextStyle(color: Color(0xFFE0DADA),
      ),
    ) ,
    backgroundColor:Color(0xFF81A7D6) ,

    colorText: Colors.white,
  );
}