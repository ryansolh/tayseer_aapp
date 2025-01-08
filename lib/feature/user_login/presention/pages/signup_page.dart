import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import '../../../../core/component/my_custom_buttons.dart';
import '../../../../core/component/my_custom_subtitle.dart';
import '../../../../core/component/my_custom_title.dart';
import '../../../basic_navigation_page/presention/page/navigation_page.dart';
import '../widgets/input_widget.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  SignUp({super.key});


  @override
  Widget build(BuildContext context) {

    Size sizeOfScreen = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .background,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Theme
              .of(context)
              .colorScheme
              .secondary,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          color: Theme
              .of(context)
              .colorScheme
              .background,
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
                    Column(
                      children: const <Widget>[
                        MyTitle(textOfTitle: "تسجيل الدخول", startDelay: 500),
                        SizedBox(height: 20,),
                        MySubTitle(textOfSubTitle: "قم بإخال بيانات حسابك",
                            startDelay: 700)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          FadeInUp(
                              duration: const Duration(milliseconds: 1200),
                              child: makeInput(
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
                          20.SH,
                          FadeInUp(duration: const Duration(milliseconds: 1300),
                              child: makeInput(
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
                        ],
                      ),
                    ),
                    50.SH,
                    FadeInUp(duration: const Duration(milliseconds: 1400),
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
                                  context.push(const NavigationScreen());

                                }
                            )
                        )
                    ),
                    20.SH,
                    FadeInUp(
                        duration: const Duration(milliseconds: 1500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const MySubTitle(
                                textOfSubTitle: "?Don't have an account",
                                startDelay: 800),
                            GestureDetector(
                              child: Text(
                                "   Sign up",
                                style: TextStyle(
                                  color: const Color(0xFF75B6E3),
                                  fontWeight: FontWeight.w500,
                                  fontSize: sizeOfScreen.height * 0.019,
                                ),
                              ),
                            ),

                          ],
                        )
                    ),

                    Expanded(
                      flex: 1,

                      child: FadeInUp(
                          duration: const Duration(milliseconds: 1200),
                          child: SizedBox(
                            height: sizeOfScreen.height / 4,
                            child: Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/ImagesForLoginAndSignupPages/Reset-password.png'),
                                  )
                              ),
                            ),
                          )
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
