import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:todo_apps/core/component/my_custom_shadermask.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/feature/user_login/presention/pages/forget_pass_page.dart';
import 'package:todo_apps/feature/user_login/presention/pages/signup_page.dart';
import '../../../../core/component/my_custom_buttons.dart';
import '../../../../core/component/my_custom_subtitle.dart';
import '../../../../core/component/my_custom_title.dart';
import '../../../basic_navigation_page/presention/page/navigation_page.dart';
import '../widgets/input_widget.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {

    Size sizeOfScreen = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Container(
        color: Theme
            .of(context)
            .colorScheme
            .background,
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 22,right: 5),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: (){
                        context.pop();
                      },
                            icon: MyShaderMask(
                              radius: 1.3,
                              toolWidget: Icon(
                                Icons.chevron_right_sharp,
                                size: 40,color: Colors.white,
                              ),
                            )
                        )
                  ),
              ),
                
              MyTitle(textOfTitle: "تسجيل الدخول", startDelay: 500),
              MySubTitle(textOfSubTitle: "قم بإخال بيانات حسابك",
                  startDelay: 700),
                
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: <Widget>[
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: SizedBox(
                          height: sizeOfScreen.height / 4,
                          child: Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/ImagesForLoginAndSignupPages/Reset-password.png'),
                                )
                            ),
                          ),
                        )
                    ),
                    20.SH,
                    FadeInUp(
                
                        duration: const Duration(milliseconds: 1200),
                        child: makeInput(
                          prefixIcon: Icon(Icons.mail),
                          inputController: emailController,
                          context: context,
                          Height: sizeOfScreen.height * 0.1 * 0.75,
                          Width: sizeOfScreen.width > sizeOfScreen.height
                              ? sizeOfScreen.height - 100
                              : double.infinity,
                          sizeOfScreen: sizeOfScreen,
                          label: "Email",
                
                        )
                
                    ),
                    10.SH,
                    FadeInUp(duration: const Duration(milliseconds: 1300),
                        child: makeInput(
                            prefixIcon: Icon(Icons.lock),
                            context: context,
                            sizeOfScreen: sizeOfScreen,
                            Height: sizeOfScreen.height * 0.1 * 0.75,
                            Width: sizeOfScreen.width >
                                sizeOfScreen.height ? sizeOfScreen
                                .height - 100 : double.infinity,
                            label: "Password",
                            inputController: passController,
                            obscureText: true)
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: FadeInUp(
                          duration: const Duration(milliseconds: 1350),
                          child: InkWell(
                            child: MySubTitle(
                              startDelay: 1000,
                              textOfSubTitle: "?forget password",
                              textColor: Color(0xFF75B6E3),
                              textSize: sizeOfScreen.height*0.017,
                            ),
                            onTap: (){
                              context.push(ForgetPassPage());
                            },
                          ),
                      ),
                    )
                  ],
                ),
              ),
              30.SH,
                
              FadeInUp(duration: const Duration(milliseconds: 1400),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: MyButtonWithBackground(
                        context: context,
                          textButton: 'تسجيل الدخول',
                          height: sizeOfScreen.height * 0.1 * 0.75,
                          width: sizeOfScreen.width > sizeOfScreen.height
                              ? sizeOfScreen.height - 100
                              : double.infinity,
                          onPressed: () {
                           // LoginAuth(emailController.text,passController.text);
                            context.push(const NavigationScreen());
                          }
                      )
                  )
              ),
              10.SH,
              FadeInUp(
                  duration: const Duration(milliseconds: 1500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child: MySubTitle(
                          startDelay: 1000,
                          textOfSubTitle: "   انشاء حساب",
                          textColor: Color(0xFF75B6E3),
                          textSize: sizeOfScreen.height*0.017,
                        ),
                        onTap: (){
                          context.pushReplacement(SignupPage());
                        },
                      ),
                       MySubTitle(
                          textOfSubTitle: "هل لديك حساب ?",
                          startDelay: 800,
                        textSize: sizeOfScreen.height*0.017,
                      ),
                
                
                    ],
                  )
              ),
              40.SH
                
                
            ],
          ),
        ),
      ),


    );
  }
}
