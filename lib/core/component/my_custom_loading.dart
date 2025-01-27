import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:todo_apps/core/component/my_custom_shadermask.dart';



class MyCustomLoading extends StatelessWidget {
  const MyCustomLoading({Key? key,}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return MyShaderMask(
        toolWidget: LoadingAnimationWidget.fourRotatingDots(
            color: Color(0xFF81A7D6),
            size: MediaQuery.of(context).size.width/8.5
        ),
        radius: 1
    );
  }
}
