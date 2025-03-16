import 'dart:convert';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/feature/user_login/presention/pages/login_screen.dart';

import '../../../../core/component/my_custom_buttons.dart';
import '../../../../core/component/my_custom_shadermask.dart';
import '../../../../core/component/my_custom_subtitle.dart';
import '../../../../core/component/my_custom_title.dart';
import '../../../../core/services/user_services/user_services.dart';
import '../../../platform/presention/pages/add_and_edit_post_page.dart';
import '../widgets/input_widget.dart';

class SignupPage extends StatefulWidget {

  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  final TextEditingController _confirmPassController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _disabilityTypeController = TextEditingController();

  List<String> _targetGroup=[
    'ناشط أو مؤثر'
  ];

  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null){
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
  String? getStringImage(File? file) {

    if (file == null) return null ;
    return base64Encode(file.readAsBytesSync());
  }


  @override
  Widget build(BuildContext context) {

    Size sizeOfScreen = MediaQuery.of(context).size;

    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: SingleChildScrollView(
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
                      textOfSubTitle: "قم بادخال بيانات الحساب المراد انشاءه", startDelay: 700)
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: <Widget>[
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      child: makeInput(
                        rtlDirection: true,
                        hint: "ادخل اسمك الرباعي",
                        prefixIcon: const Icon(Icons.supervisor_account_rounded),
                        context: context,
                        sizeOfScreen: sizeOfScreen,
                        Height: sizeOfScreen.height * 0.1 * 0.75,
                        Width: sizeOfScreen.width > sizeOfScreen.height
                            ? sizeOfScreen.height - 100
                            : double.infinity,
                        label: "الاسم",
                        inputController:_nameController,
                      ),
                    ),
                
                    Row(
                      children: [
                        Expanded(
                          child: FadeInUp(
                            duration: const Duration(milliseconds: 1000),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text("اختر صورة", style: TextStyle(
                                      fontSize: sizeOfScreen.height*0.018,
                                      fontWeight: FontWeight.w400,
                                      color:Theme.of(context).colorScheme.secondary
                                  ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                                 5.SH,
                                Padding(
                                  padding: EdgeInsets.only(bottom: 4.5),
                                  child: Container(
                                    height: 144,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(3)),
                                      border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
                                        image: _imageFile == null ? null : DecorationImage(
                                            image: FileImage(_imageFile ?? File('')),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        icon: Icon(Icons.image, size:50, color: Colors.black38),
                                        onPressed: (){
                                          getImage();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        10.SW,
                        Expanded(
                          child: Column(
                            children: [
                              FadeInUp(
                                duration: const Duration(milliseconds: 1000),
                                child: makeInput(
                                  readOnly: true,
                                  hint: _targetGroup.length!=0 ?_targetGroup.toString():'',
                                  prefixIcon: MyShaderMask(
                                      toolWidget:  PopupMenuButton<String>(
                                        enableFeedback: false,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                        ),
                                        color: Theme.of(context).colorScheme.background,
                                        // color: Get.isDarkMode ? darkGreyColor : Colors.white,
                                        icon: const Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                                        padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                
                                        itemBuilder: (BuildContext context) {
                
                                          return [
                
                                            CheckedPopupMenuItem(
                                              checked:_targetGroup.contains("ناشط أو مؤثر")?true:false ,
                                              child: Text("ناشط أو مؤثر"),
                                              value: "ناشط أو مؤثر",
                                              onTap: (){
                                               setState(() {
                                                 _targetGroup.contains("ناشط أو مؤثر")?
                                                 _targetGroup.removeWhere((_targetGroup)=> _targetGroup=="ناشط أو مؤثر"):
                                                 _targetGroup.add("ناشط أو مؤثر");
                                               });
                                              },
                                            ),
                                            CheckedPopupMenuItem(
                                              checked:_targetGroup.contains("إعاقة سمعية")?true:false ,
                                              child: Text("إعاقة سمعية"),
                                              value: "إعاقة سمعية",
                                              onTap: (){
                                                setState(() {
                                                  _targetGroup.contains("إعاقة سمعية")?
                                                  _targetGroup.removeWhere((_targetGroup)=> _targetGroup=="إعاقة سمعية"):
                                                  _targetGroup.add("إعاقة سمعية");
                                                });
                                              },
                                            ),
                                            CheckedPopupMenuItem(
                                              checked:_targetGroup.contains("إعاقة بصرية")?true:false ,
                                              child: Text("إعاقة بصرية"),
                                              value: "إعاقة بصرية",
                                              onTap: (){
                                                setState(() {
                                                  _targetGroup.contains("إعاقة بصرية")?
                                                  _targetGroup.removeWhere((_targetGroup)=> _targetGroup=="إعاقة بصرية"):
                                                  _targetGroup.add("إعاقة بصرية");
                                                });
                                              },
                                            ),
                                            CheckedPopupMenuItem(
                                              checked:_targetGroup.contains("إعاقة حركية")?true:false ,
                                              child: Text("إعاقة حركية"),
                                              value: "إعاقة حركية",
                                              onTap: (){
                                                setState(() {
                                                  _targetGroup.contains("إعاقة حركية")?
                                                  _targetGroup.removeWhere((_targetGroup)=> _targetGroup=="إعاقة حركية"):
                                                  _targetGroup.add("إعاقة حركية");
                                                });
                                              },
                                            ),
                                            CheckedPopupMenuItem(
                                              checked:_targetGroup.contains("إعاقة إدراكية")?true:false ,
                                              child: Text("إعاقة إدراكية"),
                                              value: "إعاقة إدراكية",
                                              onTap: (){
                                                setState(() {
                                                  _targetGroup.contains("إعاقة إدراكية")?
                                                  _targetGroup.removeWhere((_targetGroup)=> _targetGroup=="إعاقة إدراكية"):
                                                  _targetGroup.add("إعاقة إدراكية");
                                                });
                                              },
                                            ),
                                            CheckedPopupMenuItem(
                                              checked:_targetGroup.contains("اخرئ")?true:false ,
                                              child: Text("اخرئ"),
                                              value: "اخرئ",
                                              onTap: (){
                                                setState(() {
                                                  _targetGroup.contains("اخرئ")?
                                                  _targetGroup.removeWhere((_targetGroup)=> _targetGroup=="اخرئ"):
                                                  _targetGroup.add("اخرئ");
                                                });
                                              },
                                            ),
                                          ];
                                        },
                                      ),
                                      radius: 1.3
                                  ),
                                  context: context,
                                  sizeOfScreen: sizeOfScreen,
                                  Height: sizeOfScreen.height * 0.1 * 0.75,
                                  Width: sizeOfScreen.width > sizeOfScreen.height
                                      ? sizeOfScreen.height - 100
                                      : double.infinity,
                                  label: "الفئة المستهدفة",
                
                
                                ),
                               ),
                
                              FadeInUp(
                                duration: const Duration(milliseconds: 1000),
                                child: makeInput(
                                  hint: "ادخل رقم الهاتف",
                                  prefixIcon: const Icon(Icons.phone),
                                  context: context,
                                  sizeOfScreen: sizeOfScreen,
                                  Height: sizeOfScreen.height * 0.1 * 0.75,
                                  Width: sizeOfScreen.width > sizeOfScreen.height
                                      ? sizeOfScreen.height - 100
                                      : double.infinity,
                                  label: "رقم الهاتف",
                                  inputController: _phoneNumberController,
                                ),
                              ),
                
                            ],
                          ),
                        ),
                      ],
                    ),
                    FadeInUp(
                        duration: const Duration(milliseconds: 1100),
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
                          inputController: _emailController,
                        ),
                    ),
                
                
                    FadeInUp(
                        duration: const Duration(milliseconds: 1200),
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
                            obscureText: true)),
                    FadeInUp(
                
                        duration: const Duration(milliseconds: 1300),
                        child: makeInput(
                            hint: "تأكيد كلمة المرور",
                            prefixIcon: const Icon(Icons.lock),
                            context: context,
                            sizeOfScreen: sizeOfScreen,
                            Height: sizeOfScreen.height * 0.1 * 0.75,
                            Width: sizeOfScreen.width > sizeOfScreen.height
                                ? sizeOfScreen.height - 100
                                : double.infinity,
                            label: "تأكيد كلمة المرور",
                            inputController: _confirmPassController,
                            obscureText: true)),
                  ],
                ),
              ),
              30.SH,
              FadeInUp(
                  duration: const Duration(milliseconds: 1400),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: MyButtonWithBackground(
                        context: context,
                          textButton: 'إنشاء حساب',
                          height: sizeOfScreen.height * 0.1 * 0.75,
                          width: sizeOfScreen.width > sizeOfScreen.height
                              ? sizeOfScreen.height - 100
                              : double.infinity,
                          onPressed: () {
                            SignUpAuth(
                                _nameController.text,
                                _emailController.text,
                                _passController.text
                            );
                           // context.push(PostForm(title: "انشاء منشور",));
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

                         // context.pushReplacement(LoginScreen());
                        },
                      ),
                       MySubTitle(
                          textOfSubTitle: "تمتلك حسابا؟",
                        startDelay: 300,
                        textSize: sizeOfScreen.height*0.017,
                      ),
                
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}









/*
الإعاقة الحركية
الإعاقة البصرية
الإعاقة السمعية
الإعاقة الذهنية
اضطرابات النطق والتواصل
اضطرابات طيف التوحد
اضطراب فرط الحركة وتشتت الانتباه (ADHD)
الإعاقة النفسية والاجتماعية
الإعاقة الحسية المتعددة
متلازمة داون
الشلل الدماغي
صعوبات التعلم
الإعاقة الإدراكية
الإعاقة النمائية
*/





