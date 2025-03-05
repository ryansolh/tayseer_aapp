import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/feature/user_login/presention/pages/login_screen.dart';

import '../../../../core/component/my_custom_buttons.dart';
import '../../../../core/component/my_custom_shadermask.dart';
import '../../../../core/component/my_custom_subtitle.dart';
import '../../../../core/component/my_custom_title.dart';
import '../../../../core/services/user_services/user_services.dart';
import '../widgets/input_widget.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {

    Size sizeOfScreen = MediaQuery.of(context).size;

    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20,right: 5),
                child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: (){
                          context.pop();
                        },
                        icon: const MyShaderMask(
                          radius: 1.3,
                          toolWidget: Icon(
                            Icons.chevron_right_sharp,
                            size: 40,color: Colors.white,
                          ),
                        )
                    )
                ),
              ),
              const Column(
                children:  <Widget>[

                  MyTitle(textOfTitle: "إنشاء حساب", startDelay: 500),

                  MySubTitle(
                      textOfSubTitle: "قم بانشاء حسابك", startDelay: 700)
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: <Widget>[
                    FadeInUp(
                      duration: const Duration(milliseconds: 1200),
                      child: makeInput(
                        prefixIcon: const Icon(Icons.supervisor_account_rounded),
                        context: context,
                        sizeOfScreen: sizeOfScreen,
                        Height: sizeOfScreen.height * 0.1 * 0.75,
                        Width: sizeOfScreen.width > sizeOfScreen.height
                            ? sizeOfScreen.height - 100
                            : double.infinity,
                        label: "الاسم",
                        inputController:nameController,
                      ),
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: makeInput(
                          prefixIcon: const Icon(Icons.mail),
                          context: context,
                          sizeOfScreen: sizeOfScreen,
                          Height: sizeOfScreen.height * 0.1 * 0.75,
                          Width: sizeOfScreen.width > sizeOfScreen.height
                              ? sizeOfScreen.height - 100
                              : double.infinity,
                          label: "Email",
                          inputController: emailController,
                        ),
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: makeInput(
                            prefixIcon: const Icon(Icons.lock),
                            context: context,
                            sizeOfScreen: sizeOfScreen,
                            Height: sizeOfScreen.height * 0.1 * 0.75,
                            Width: sizeOfScreen.width > sizeOfScreen.height
                                ? sizeOfScreen.height - 100
                                : double.infinity,
                            label: "Password",
                            inputController: passController,
                            obscureText: true)),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: makeInput(
                            prefixIcon: const Icon(Icons.lock),
                            context: context,
                            sizeOfScreen: sizeOfScreen,
                            Height: sizeOfScreen.height * 0.1 * 0.75,
                            Width: sizeOfScreen.width > sizeOfScreen.height
                                ? sizeOfScreen.height - 100
                                : double.infinity,
                            label: "Confirm Password",
                            inputController: passController,
                            obscureText: true)),
                  ],
                ),
              ),
              FadeInUp(
                  duration: const Duration(milliseconds: 1400),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: MyButtonWithBackground(
                        context: context,
                          textButton: 'Sign Up',
                          height: sizeOfScreen.height * 0.1 * 0.75,
                          width: sizeOfScreen.width > sizeOfScreen.height
                              ? sizeOfScreen.height - 100
                              : double.infinity,
                          onPressed: () {
                            SignUpAuth(
                                nameController.text,
                                emailController.text,
                                passController.text
                            );
                          }))),
              FadeInUp(
                  duration: const Duration(milliseconds: 1500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        child:  MySubTitle(
                          textOfSubTitle: "   تسجيل الدخول",
                          startDelay: 300,
                          textColor: Color(0xFF75B6E3),
                          textSize: sizeOfScreen.height*0.017,
                        ),
                        onTap: (){
                          context.pushReplacement(LoginScreen());
                        },
                      ),
                       MySubTitle(
                          textOfSubTitle: "تمتلك حسابا؟",
                        startDelay: 300,
                        textSize: sizeOfScreen.height*0.017,
                      ),

                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
