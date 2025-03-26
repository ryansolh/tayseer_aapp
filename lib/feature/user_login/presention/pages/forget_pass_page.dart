import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:todo_apps/core/component/my_custom_shadermask.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/feature/user_login/presention/pages/otp_page.dart';
import '../../../../core/component/my_custom_buttons.dart';
import '../../../../core/component/my_custom_subtitle.dart';
import '../../../../core/component/my_custom_title.dart';
import '../../../../core/component/input_widget.dart';
class ForgetPassPage extends StatelessWidget {
   ForgetPassPage({super.key});
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size sizeOfScreen = MediaQuery
        .of(context)
        .size;
    return Scaffold(
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
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 22,right: 5),
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

              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          FadeInUp(
                              duration: const Duration(milliseconds: 1200),
                              child: SizedBox(
                                height: sizeOfScreen.height / 3,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/images/ImagesForLoginAndSignupPages/Forgot-password.png'),
                                      )
                                  ),
                                ),
                              )
                          ),
                          const MyTitle(textOfTitle: "ادخل البريد الالكتروني", startDelay: 500),
                          const MySubTitle(textOfSubTitle: "يرجى إدخال بريدك الالكتروني المسجل لدينا وسنرسل لك كود سري لاثبات ملكيتك للحساب واعادة تعيين كلمة السر ",
                              startDelay: 700),
                          FadeInUp(

                              duration: const Duration(milliseconds: 1200),
                              child: makeInput(
                                hint: "أدخل البريد الالكتروني",
                                prefixIcon: Icon(Icons.mail),
                                inputController: emailController,
                                context: context,
                                Height: sizeOfScreen.height * 0.1 * 0.75,
                                Width: sizeOfScreen.width > sizeOfScreen.height
                                    ? sizeOfScreen.height - 100
                                    : double.infinity,
                                sizeOfScreen: sizeOfScreen,
                                label: "البريد الالكتروني",

                              )

                          ),

                        ],
                      ),
                    ),

                    100.SH,




                    FadeInUp(duration: const Duration(milliseconds: 1400),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: MyButtonWithBackground(
                                context: context,
                                textButton: 'متابعة',
                                height: sizeOfScreen.height * 0.1 * 0.75,
                                width: sizeOfScreen.width > sizeOfScreen.height
                                    ? sizeOfScreen.height - 100
                                    : double.infinity,
                                onPressed: () {
                                  // LoginAuth(emailController.text,passController.text);
                                  context.push(const OtpPage());
                                }
                            )
                        )
                    ),


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
