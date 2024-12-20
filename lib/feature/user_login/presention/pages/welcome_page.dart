import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/feature/user_login/presention/pages/signin_page.dart';
import 'package:todo_apps/feature/user_login/presention/pages/signup_page.dart';
import '../../../../core/component/my_custom_buttons.dart';
import '../../../../core/component/my_custom_subtitle.dart';
import '../../../../core/component/my_custom_title.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size sizeOfScreen=MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 30,

        ),
        child: Container(
          color: Theme.of(context).colorScheme.background,
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children:  <Widget>[
                          50.SH,
                          const MyTitle(textOfTitle: "أهلاً بك", startDelay: 0),
                          const SizedBox(height: 20,),
                          const MySubTitle(textOfSubTitle: "ادخل لصفحة Sign Up وادخل بيانات الحساب الذي يمكّن منه التحقق من هويتك.قم بإخال بيانات حسابك",
                              startDelay: 0)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          FadeInUp(
                              duration: const Duration(milliseconds: 800),
                              child: SizedBox(
                                height: sizeOfScreen.height/3,
                                child: Container(

                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/ImagesForLoginAndSignupPages/Profile-Interface.png'),

                                      )
                                  ),
                                ),
                              )
                          ),
                         // 20.SH,
                          ////////////////////////////////////////
                        ],
                      ),
                    ),
                    50.SH,



                    Expanded(
                      flex: 1,

                      child: Column(
                        children: [
                          FadeInUp(
                              delay: const Duration(milliseconds: 0),
                              child: MyButtonNoBackground(
                                context,
                                  textButton: 'Sign In',
                                  Height: sizeOfScreen.height*0.1*0.75,
                                  Width: sizeOfScreen.width>sizeOfScreen.height? sizeOfScreen.height-100:double.infinity,

                                  onPressed: (){
                                    context.push(SignInPage());
                                  }
                              )
                          ),
                          20.SH,
                          FadeInUp(
                              delay: const Duration(milliseconds: 0),
                              child: MyButtonWithBackground(
                                context: context,
                                  textButton: 'Sign Up',
                                  height: sizeOfScreen.height*0.1*0.75,
                                  width: sizeOfScreen.width>sizeOfScreen.height? sizeOfScreen.height-100:double.infinity,

                                  onPressed: (){
                                    context.push(SignUp());
                                  }
                              )
                          ),
                        ],
                      ),
                    )
                    /////////////
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}


