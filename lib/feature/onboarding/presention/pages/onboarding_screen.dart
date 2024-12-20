import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
// import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';

import '../../../user_login/presention/pages/welcome_page.dart';


class Onboarding extends StatefulWidget {
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {

   double _HeightOfScreen = MediaQuery.of( context).size.height;
   double _WidthOfScreen = MediaQuery.of(context).size.width;

   final List<Introduction> list =
   [

     Introduction(

       titleTextStyle: TextStyle(
           color:  const Color(0xFF9D6CAE),
           fontSize: _HeightOfScreen*0.028,
       ),
       subTitleTextStyle:TextStyle(
           color:Colors.black,
           fontSize: _HeightOfScreen*0.020
       ),

       title: 'Fashion Store',
       subTitle: 'Browse the menu and order directly from the application',
       imageUrl: 'assets/images/logo_of_app/TAYSEER.png',
     ),
     Introduction(
       titleTextStyle: TextStyle(
           color:  const Color(0xFF9D6CAE),
           fontSize: _HeightOfScreen*0.028
       ),

       subTitleTextStyle:TextStyle(
           color:  Colors.black,
           fontSize: _HeightOfScreen*0.020
       ),
       title: 'Delivery',
       subTitle: 'Your order will be immediately collected and',
       imageUrl: 'assets/images/logo_of_app/TAYSEER.png',
     ),
     Introduction(
       titleTextStyle: TextStyle(
           color:  const Color(0xFF9D6CAE),
           fontSize: _HeightOfScreen*0.028
       ),
       subTitleTextStyle:TextStyle(
           color:  Colors.black,
           fontSize: _HeightOfScreen*0.020
       ),
       title: 'Receive Money',
       subTitle: 'Pick up delivery at your door and enjoy groceries',
       imageUrl: 'assets/images/logo_of_app/TAYSEER.png',
     ),
   ];
    return  IntroScreenOnboarding(
        backgroudColor: const Color(0xFFf9f9f9),
        foregroundColor: const Color(0xFF61498C),
        introductionList: list,
        onTapSkipButton: () {
          Navigator.push(context, MaterialPageRoute(
                builder: (context) =>WelcomePage() ,
              )
          );
        },
        skipTextStyle: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 18,
        ),
      );
  }
}