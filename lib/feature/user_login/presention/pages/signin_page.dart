import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../../core/component/my_custom_buttons.dart';
import '../../../../core/component/my_custom_subtitle.dart';
import '../../../../core/component/my_custom_title.dart';
import '../widgets/input_widget.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size sizeOfScreen = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).colorScheme.background,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: const <Widget>[
                    MyTitle(textOfTitle: "إنشاء حساب", startDelay: 500),
                    SizedBox(
                      height: 20,
                    ),
                    MySubTitle(
                        textOfSubTitle: "قم بانشاء حسابك", startDelay: 700)
                  ],
                ),
                Column(
                  children: <Widget>[
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: makeInput(
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
                FadeInUp(
                    duration: const Duration(milliseconds: 1400),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: MyButtonWithBackground(
                          context: context,
                            textButton: 'Sign In',
                            height: sizeOfScreen.height * 0.1 * 0.75,
                            width: sizeOfScreen.width > sizeOfScreen.height
                                ? sizeOfScreen.height - 100
                                : double.infinity,
                            onPressed: () {}))),
                FadeInUp(
                    duration: const Duration(milliseconds: 1500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const MySubTitle(
                            textOfSubTitle: "انا امتلك حسابا", startDelay: 300),
                        GestureDetector(
                          child: Text(
                            "   تسجيل الدخول",
                            style: TextStyle(
                              color: const Color(0xFF75B6E3),
                              fontWeight: FontWeight.w500,
                              fontSize: sizeOfScreen.height * 0.019,
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
