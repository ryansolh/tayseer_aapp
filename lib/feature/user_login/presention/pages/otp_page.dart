import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';

import '../../../../core/component/my_custom_buttons.dart';
import '../../../../core/component/my_custom_shadermask.dart';
import '../../../../core/component/my_custom_subtitle.dart';
import '../../../../core/component/my_custom_title.dart';
import '../../../basic_navigation_page/presention/page/navigation_page.dart';
import '../widgets/otp_input.dart';
class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

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
                
              Column(
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
                                          'assets/images/ImagesForLoginAndSignupPages/Enter-OTP.png'),
                                    )
                                ),
                              ),
                            )
                        ),
                        30.SH,
                        const MyTitle(textOfTitle: "ادخل رمز التحقق", startDelay: 500),
                        const MySubTitle(
                            textOfSubTitle: "لقد ارسلنا رمز تحقق مكون من 4 ارقام الى البريد الالكتروني الخاص بك.",
                            textColor: Colors.grey,
                            startDelay: 700),
                        const OtpInput()

                      ],
                    ),
                  ),




                  100.SH,
                  FadeInUp(duration: const Duration(milliseconds: 1400),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: MyButtonWithBackground(
                              context: context,
                              textButton: 'ارسال',
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


                  /////////////
                ],
              ),
                
                
            ],
          ),
        ),
      ),
    );
  }
}
