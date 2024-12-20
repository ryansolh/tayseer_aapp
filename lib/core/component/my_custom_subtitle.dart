import 'package:flutter/material.dart';

import 'my_custom_slide_fade_transition.dart';


class MySubTitle extends StatelessWidget {
  const MySubTitle({Key? key,required this.textOfSubTitle,required this.startDelay}) : super(key: key);
  final String textOfSubTitle;
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
      child:Padding(
        padding:EdgeInsets.all(16),
        child: Text(textOfSubTitle,
          softWrap: true,
          textAlign: TextAlign.justify,

          style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: height*0.020,wordSpacing: -5),
          textDirection: TextDirection.rtl,



        ),
      ),
    );
  }
}
