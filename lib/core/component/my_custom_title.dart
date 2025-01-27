import 'package:flutter/material.dart';

import 'my_custom_slide_fade_transition.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({Key? key,required this.textOfTitle,required this.startDelay}) : super(key: key);
  final String textOfTitle;
  final int startDelay;


  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return SlideFadeTransition(
      curve: Curves.elasticInOut,
      delayStart: Duration(milliseconds: startDelay),
      animationDuration: const Duration(milliseconds: 1200),
      offset: 2.5,
      direction: Direction.horizontal,
      child: ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (Rect bounds)
        {
          return const RadialGradient
            (
            center: Alignment.topRight,

            radius: 3,
            colors: <Color>
            [
              Color(0xFF9D6CAE), // أزرق داكن
              Color(0xFF967EB9), // أزرق
              Color(0xFF81A7D6), // أزرق فاتح
              Color(0xFF75B6E3), // أزرق أفتح
            ],
            tileMode: TileMode.mirror,
          ).createShader(bounds);

        },
        child: Text(textOfTitle,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.bold,
            fontSize: height*0.024,


          ),
          textDirection: TextDirection.rtl,

        ),


      ),
    );
  }
}
