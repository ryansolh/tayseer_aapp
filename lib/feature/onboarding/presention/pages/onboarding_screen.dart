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
           fontSize: _HeightOfScreen*0.020,

       ),

       title: '!  مرحبًا بك في تيسير',
       subTitle: 'تطبيق شامل لدعم وتمكين الأشخاص ذوي الهمم، يساعدك في العثور على الخدمات، تنظيم مهامك، والانضمام إلى مجتمع داعم بكل سهولة',
       imageUrl: 'assets/images/OnBoarding-Screen-Image/Welecom-to-tayseer.png',
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
       title: '!  كل ما تحتاجه في مكان واحد',
       subTitle: 'استكشف دليل الخدمات، احصل على توصيات مخصصة، وتعرف على الأماكن المجهزة بسهولة. كل الخدمات التي تسهل حياتك في متناول يدك',
       imageUrl: 'assets/images/OnBoarding-Screen-Image/CentersAndServices.png',
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
       title: '!لا تفوت أي موعد مهم',
       subTitle: 'قم بجدولة مهامك اليومية، حدد مواعيد الأدوية، واحصل على تذكيرات ذكية لتنظيم يومك بكل سهولة',
       imageUrl: 'assets/images/OnBoarding-Screen-Image/reminder.png',
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
       title: ' ! ابحث، اشتري، وبيع بسهولة',
       subTitle: 'اكتشف سوقًا مخصصًا لبيع وشراء الأدوات المساعدة والمعدات الطبية، كل ذلك في بيئة آمنة وسهلة الاستخدام',
       imageUrl: 'assets/images/OnBoarding-Screen-Image/market.png',
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
       title: '!مساعد ذكي لك',
       subTitle: 'استفد من النصائح المخصصة، واسأل الذكاء الاصطناعي عن أي استفسارات حول احتياجاتك اليومية، لتحصل على تجربة أكثر سهولة وراحة',
       imageUrl: 'assets/images/OnBoarding-Screen-Image/AI.png',
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