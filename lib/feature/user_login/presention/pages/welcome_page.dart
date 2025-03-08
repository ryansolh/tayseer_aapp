import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/feature/user_login/presention/pages/login_screen.dart';
import 'package:todo_apps/feature/user_login/presention/pages/signup_page.dart';
import '../../../../core/component/my_custom_buttons.dart';
import '../../../../core/component/my_custom_subtitle.dart';
import '../../../../core/component/my_custom_title.dart';
import '../../../basic_navigation_page/presention/page/navigation_page.dart';

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
        child: SingleChildScrollView(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    50.SH,
                    const MyTitle(textOfTitle: "أهلاً بك", startDelay: 0),
                    const SizedBox(height: 20,),
                    const MySubTitle(textOfSubTitle: "اذا كنت لا تمتلك حساباً, ادخل لصفحة انشاء حساب وادخل بيانات الحساب المراد إنشائه والذي يمكّن من خلاله التحقق من هويتك. وان كنت تمتلك حساباً من قبل, ادخل صفحة تسجيل الدخول وقم بادخال بيانات حسابك. ",
                        startDelay: 0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: FadeInUp(
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
                    ),
                    50.SH,
          
          
          
                    Column(
                      children: [
                        FadeInUp(
                            delay: const Duration(milliseconds: 0),
                            child: MyButtonNoBackground(
                              context,
                                textButton: 'انشاء حساب',
                                Height: sizeOfScreen.height*0.1*0.75,
                                Width: sizeOfScreen.width>sizeOfScreen.height? sizeOfScreen.height-100:double.infinity,
          
                                onPressed: (){
                                  context.push(SignupPage());
                                }
                            )
                        ),
                        20.SH,
                        FadeInUp(
                            delay: const Duration(milliseconds: 0),
                            child: MyButtonWithBackground(
                              context: context,
                                textButton: 'تسجيل الدخول',
                                height: sizeOfScreen.height*0.1*0.75,
                                width: sizeOfScreen.width>sizeOfScreen.height? sizeOfScreen.height-100:double.infinity,
          
                                onPressed: (){
                                  context.push(LoginScreen());
                                }
                            )
                        ),
                        20.SH,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              child:  MySubTitle(
                                textOfSubTitle: "كزائر",
                                startDelay: 300,
                                textColor: Color(0xFF75B6E3),
                                textSize: sizeOfScreen.height*0.017,
                              ),
                              onTap: (){
                                context.pushReplacement(const NavigationScreen());
                              },
                            ),
                            MySubTitle(
                              textOfSubTitle: "تصفح التطبيق",
                              startDelay: 300,
                              textSize: sizeOfScreen.height*0.017,
                            ),

                          ],
                        ),
                      ],
                    )
                    /////////////
                  ],
                ),
          
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}


