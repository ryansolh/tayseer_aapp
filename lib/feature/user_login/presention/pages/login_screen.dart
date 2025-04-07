import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:todo_apps/core/component/my_custom_shadermask.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/core/network/remote/remote_dio.dart';
import 'package:todo_apps/core/utils/app_constants/blog_app_constants.dart';
import 'package:todo_apps/feature/user_login/presention/pages/forget_pass_page.dart';
import 'package:todo_apps/feature/user_login/presention/pages/signup_page.dart';
import 'package:todo_apps/feature/user_login/presention/pages/welcome_page.dart';
import '../../../../cache/cache_helper.dart';
import '../../../../core/component/my_custom_buttons.dart';
import '../../../../core/component/my_custom_loading.dart';
import '../../../../core/component/my_custom_subtitle.dart';
import '../../../../core/component/my_custom_title.dart';
import '../../../../core/services/confirmed_app_message_sevice/snakbar_message_sevice.dart';
import '../../../basic_navigation_page/presention/page/navigation_page.dart';
import '../../data_models/register_model.dart';
import '../../../../core/component/input_widget.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {

  LoginScreen({super.key, required this.fromWelcompage});

 final bool fromWelcompage;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passController = TextEditingController();

 bool isPassError=false;
 bool isEmailError=false;
 bool _sendButtonClicked=false;
  

  var formKey = GlobalKey<FormState>();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

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
                        widget.fromWelcompage==true?
                        context.pushReplacement(WelcomePage())
                            :context.pop();
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
                child: Form(
                  key: formKey,
                  autovalidateMode: autoValidateMode,
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
                            hint: "أدخل البريد الالكتروني",
                            prefixIcon: const Icon(Icons.mail),
                            context: context,
                            sizeOfScreen: sizeOfScreen,
                            Height: sizeOfScreen.height * 0.1 * 0.75,
                            Width: sizeOfScreen.width > sizeOfScreen.height
                                ? sizeOfScreen.height - 100
                                : double.infinity,
                            label: "البريد الالكتروني",
                            onChanged:(value){
                              setState(() {
                                if(value.startsWith(RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$'),)){
                                  isEmailError=false;
                                }
                                else
                                {
                                  isEmailError=true;
                                }

                              });
                            },
                            inputController: _emailController,
                            validatorFun: (value){
                              if(value!.isEmpty){
                                isEmailError=true;
                                return "يجب عليك تعبئة الحقل!";
                              }
                              else{
                                if(!value.startsWith(RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$'),)){
                                  isEmailError=true;
                                  return "يجب كتابة الايميل بشكل صحيح";
                                }


                              }
                            },
                            isError: _sendButtonClicked==true?isEmailError:false

                        ),
                      ),
                      10.SH,
                      FadeInUp(
                          duration: const Duration(milliseconds: 1300),
                          child: makeInput(
                              hint: "أدخل كلمة المرور",
                              prefixIcon: const Icon(Icons.lock),
                              context: context,
                              sizeOfScreen: sizeOfScreen,
                              Height: sizeOfScreen.height * 0.1 * 0.75,
                              Width: sizeOfScreen.width > sizeOfScreen.height
                                  ? sizeOfScreen.height - 100
                                  : double.infinity,
                              label: "كلمة المرور",
                              inputController: _passController,
                              obscureText: true,
                              onChanged: (value) {
                                setState(() {

                                  
                                 
                                  if(value.length>=8&&value!.isNotEmpty){
                                    isPassError=false;
                                  }

                                });
                              },
                              validatorFun: (value){
                                if(value!.isEmpty){
                                  isPassError=true;
                                  return "يجب تعبئة الحقل";
                                }else{
                                  if(value.length<8){
                                    isPassError=true;
                                    return "يجب ان تتكون كلمة المرور على الاقل من 8 احرف";
                                  }
                                }

                              },
                              isError: _sendButtonClicked==true?isPassError:false
                          )
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
                          onPressed: () async{
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return MyCustomLoading();
                                },);
                              try{
                                var response= await DioHelper.post(
                                    url: loginUrl,
                                    data: {
                                      "email": _emailController.text,
                                      "password": _passController.text
                                    }
                                );
                                if(response.statusCode==200||response.statusCode==201){
                                  try {
                                    UserResponseModel userRegisterResponse = UserResponseModel.fromJson(response.data);
                                    print(userRegisterResponse);
                                    CacheHelper.saveData(key: "token", value: "Bearer ${userRegisterResponse.user!.accessToken}");
                                    CacheHelper.saveData(key: "token2", value: userRegisterResponse.user!.accessToken);
                                    CacheHelper.saveData(key: "userId", value:userRegisterResponse.data!.userId );
                                    CacheHelper.saveData(key: "name", value:userRegisterResponse.data!.name );
                                    CacheHelper.saveData(key: "image", value:userRegisterResponse.data!.image );
                                    CacheHelper.saveData(key: "email", value:userRegisterResponse.data!.email );
                                    CacheHelper.saveData(key: "address", value:userRegisterResponse.data!.address );
                                    CacheHelper.saveData(key: "phone", value:userRegisterResponse.data!.phone );
                                    CacheHelper.saveData(key: "role", value:userRegisterResponse.data!.role );
                                    CacheHelper.saveData(key: "disabilities", value:userRegisterResponse.data!.disabilities  );
                                   print(CacheHelper.getData(key: "token"));
                                    context.pop();
                                    context.pushReplacement(NavigationScreen());

                                  } catch (e) {
                                    showCustomSnackbar
                                      (
                                        textColor: Colors.white,
                                        backgroundColor: Colors.red,
                                        title: "فشل تسجيل الدخول!!",
                                        subTitle: "حدث خطأ أثناء معالجة البيانات."
                                    );
                                    context.pop();
                                  }
                                }
                               else{
                                  showCustomSnackbar
                                    (
                                      textColor: Colors.white,
                                      backgroundColor: Colors.red,
                                      title: "فشل في تسجيل الدخول! ",
                                      subTitle: "يبدو ان هناك مشكلة ما او انك غير متصل بالانترنت."
                                  );
                                  context.pop();
                                }
                              }
                              catch(e){
                                if(e.toString().contains("401")){
                                  showCustomSnackbar
                                    (
                                      textColor: Colors.white,
                                      backgroundColor: Colors.red,
                                      title: "عذراً! تحقق من صحة البيانات ",
                                      subTitle: "قد يكون هناك خطاء في البريد الالكتروني او كلمة المرور."
                                  );
                                  context.pop();
                                }
                                else {
                                showCustomSnackbar
                                  (
                                    textColor: Colors.white,
                                    backgroundColor: Colors.red,
                                    title: "فشل في تسجيل الدخول! ",
                                    subTitle: "يبدو ان هناك مشكلة ما او انك غير متصل بالانترنت."
                                );
                                context.pop();
                                }
                              }
                              
                            } else {
                              _sendButtonClicked=true;
                              autoValidateMode = AutovalidateMode.always;
                              setState(() {});
                            }
                           // LoginAuth(emailController.text,passController.text);
                           
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
                          context.pushReplacement(SignupPage(fromWelcompage: widget.fromWelcompage,));
                        },
                      ),
                       MySubTitle(
                          textOfSubTitle: "لا تمتلك حساباً ?",
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
