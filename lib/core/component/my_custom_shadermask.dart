import 'package:flutter/material.dart';

class MyShaderMask extends StatelessWidget {
  const MyShaderMask({Key? key, required this.toolWidget,required this.radius}) : super(key: key);
  final Widget toolWidget;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,

      shaderCallback: (Rect bounds)
      {
        return  RadialGradient(
          center: Alignment.topRight,

          radius: radius,
          colors: const <Color>[
            Color(0xFF9D6CAE), // أزرق داكن
            Color(0xFF967EB9), // أزرق
            Color(0xFF81A7D6), // أزرق فاتح
            Color(0xFF75B6E3), // أزرق أفتح
          ],

          tileMode: TileMode.mirror,
        ).createShader(bounds);

      },
      child:toolWidget,


    );
  }
}
