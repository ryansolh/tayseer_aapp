import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget MyButtonNoBackground(
    BuildContext context,
    {String? textButton,
      double padding=0,
      double? Height,
      double Width = double.infinity,
      void Function()? onPressed}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF9D6CAE), // أزرق داكن
            Color(0xFF967EB9), // أزرق
            Color(0xFF81A7D6), // أزرق فاتح
            Color(0xFF75B6E3), // أزرق أفتح
            // يمكنك تعديل الألوان لتتناسب مع الصورة
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: Height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (Rect bounds) {
                return const RadialGradient(
                  center: Alignment.topRight,
                  radius: 3,
                  colors: <Color>[
                    Color(0xFF9D6CAE), // أزرق داكن
                    Color(0xFF967EB9), // أزرق
                    Color(0xFF81A7D6), // أزرق فاتح
                    Color(0xFF75B6E3), // أزرق أفتح
                  ],
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child: Padding(
                padding: padding==0? EdgeInsets.all(0):EdgeInsets.all(padding),
                child: Text(
                  textButton!,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              )),
        ),
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget MyButtonWithBackground(
    {required BuildContext context,
      String? textButton,
      double? height,
      double width = double.infinity,
      double fontSize=18,
      void Function()? onPressed}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0xFF9D6CAE), // أزرق داكن
          Color(0xFF967EB9), // أزرق
          Color(0xFF81A7D6), // أزرق فاتح
          Color(0xFF75B6E3), // أزرق أفتح
          // يمكنك تعديل الألوان لتتناسب مع الصورة
        ],
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: MaterialButton(
      minWidth: width,
      height: height,
      onPressed: onPressed,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Text(
        textButton!,
        style:  TextStyle(
            fontFamily: "Tajawal",
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold
        ),
      ),
    ),
  );
}
