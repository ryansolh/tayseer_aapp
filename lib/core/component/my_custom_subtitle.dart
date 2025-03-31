import 'package:flutter/material.dart';

import 'my_custom_slide_fade_transition.dart';


class MySubTitle extends StatelessWidget {
  const MySubTitle({Key? key,required this.textOfSubTitle,required this.startDelay,this.textColor,  this.textSize}) : super(key: key);
  final String textOfSubTitle;
  final int startDelay;
  final Color? textColor;
  final double? textSize;
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return SlideFadeTransition(
      curve: Curves.elasticOut,
      delayStart: Duration(milliseconds: startDelay),
      animationDuration: const Duration(milliseconds: 500),
      offset: 2.5,
      direction: Direction.horizontal,
      child:Padding(
        padding:EdgeInsets.all(16),
        child: Text(textOfSubTitle,
          softWrap: true,
          textAlign: TextAlign.justify,

          style: textColor!=null?Theme.of(context).textTheme.labelSmall!.copyWith(
              fontSize: textSize!=null?textSize:height*0.020,
              wordSpacing: -2
          ).copyWith(color: textColor):Theme.of(context).textTheme.labelSmall!.copyWith(
              fontSize: textSize!=null?textSize:height*0.020,
              wordSpacing: -2
          ),
          textDirection: TextDirection.rtl,



        ),
      ),
    );
  }
}
