import 'dart:convert';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_apps/core/component/my_custom_loading.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:http/http.dart' as http;
import 'package:todo_apps/core/services/confirmed_app_message_sevice/snakbar_message_sevice.dart';
import 'package:todo_apps/feature/user_login/presention/pages/welcome_page.dart';

import '../../../../cache/cache_helper.dart';
import '../../../../core/component/my_custom_buttons.dart';
import '../../../../core/component/my_custom_shadermask.dart';
import '../../../../core/component/my_custom_subtitle.dart';
import '../../../../core/component/my_custom_title.dart';
import '../../../basic_navigation_page/presention/page/navigation_page.dart';
import '../../data_models/register_model.dart';
import '../widgets/input_widget.dart';
import 'login_screen.dart';

class SignupPage extends StatefulWidget {

  SignupPage({super.key, required this.fromWelcompage});
  final bool fromWelcompage;
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  final TextEditingController _confirmPassController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  //final TextEditingController _disabilityTypeController = TextEditingController();
   bool isNameError=false;
  bool isEmailError=false;
  bool isPassError=false;
  bool isDisabilityTypeError=false;
  bool isPhoneNumError=false;
  bool isAddressError=false;
  bool isConfirmPassError=false;
  bool _sendButtonClicked=false;








  var formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  List<String> _targetGroupShow=[
    'ناشط أو مؤثر'
  ];
  List<int>_targetGroupSend=[
    6
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
          child: Form(
            key: formKey,
            autovalidateMode: autoValidateMode,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20,right: 5),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: (){
                            widget.fromWelcompage==true?
                            context.pushReplacement(WelcomePage())
                                :context.pop();

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
                          onChanged:(value){
                            setState(() {
                              if(value.isNotEmpty){
                                  isNameError=false;
                              }
                              else{
                                setState(() {
                                  isNameError=true;
                                });
                              }
                            });
                          },
                          validatorFun: (value){
                           if(value!.isEmpty){
                             isNameError=true;
                             return "يجب عليك ادخال الاسم!";
                           }

                          },
                          isError: _sendButtonClicked==true?isNameError:false
                        ),
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 900),
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
            
                  
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: FadeInUp(
                                duration: const Duration(milliseconds: 1000),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
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

                                      Padding(
                                        padding: EdgeInsets.only(top: 4),
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
                            ),
                            10.SW,
                            Expanded(
                              child: Column(
                                children: [
                                  FadeInUp(
                                    duration: const Duration(milliseconds: 1000),
                                    child: makeInput(
                                      readOnly: true,
                                      hint: _targetGroupShow.length!=0 ?_targetGroupShow.toString():'',
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

                                            onSelected: (value){
                                              setState(() {
                                                if(_targetGroupShow.isNotEmpty){

                                                  isDisabilityTypeError=false;

                                                }
                                                else{
                                                  isDisabilityTypeError=true;
                                                }
                                              });
                                            },
                                            itemBuilder: (BuildContext context) {

                                              return [

                                                CheckedPopupMenuItem(
                                                  checked:_targetGroupShow.contains("ناشط أو مؤثر")?true:false ,
                                                  child: Text("ناشط أو مؤثر"),
                                                  value: "ناشط أو مؤثر",
                                                  onTap: (){
                                                   setState(() {
                                                     _targetGroupShow.contains("ناشط أو مؤثر")?
                                                     _targetGroupShow.removeWhere((_targetGroup)=> _targetGroup=="ناشط أو مؤثر"):
                                                     _targetGroupShow.add("ناشط أو مؤثر");
                                                     _targetGroupSend.contains(6)?
                                                     _targetGroupSend.removeWhere((_targetGroup)=> _targetGroup==6)
                                                         :_targetGroupSend.add(6);
                                                   });
                                                  },
                                                ),
                                                CheckedPopupMenuItem(
                                                  checked:_targetGroupShow.contains("إعاقة سمعية")?true:false ,
                                                  child: Text("إعاقة سمعية"),
                                                  value: "إعاقة سمعية",
                                                  onTap: (){
                                                    setState(() {
                                                      _targetGroupShow.contains("إعاقة سمعية")?
                                                      _targetGroupShow.removeWhere((_targetGroup)=> _targetGroup=="إعاقة سمعية"):
                                                      _targetGroupShow.add("إعاقة سمعية");
                                                      _targetGroupSend.contains(1)?
                                                      _targetGroupSend.removeWhere((_targetGroup)=> _targetGroup==1)
                                                          :_targetGroupSend.add(1);
                                                    });
                                                  },
                                                ),
                                                CheckedPopupMenuItem(
                                                  checked:_targetGroupShow.contains("إعاقة بصرية")?true:false ,
                                                  child: Text("إعاقة بصرية"),
                                                  value: "إعاقة بصرية",
                                                  onTap: (){
                                                    setState(() {
                                                      _targetGroupShow.contains("إعاقة بصرية")?
                                                      _targetGroupShow.removeWhere((_targetGroup)=> _targetGroup=="إعاقة بصرية"):
                                                      _targetGroupShow.add("إعاقة بصرية");
                                                      _targetGroupSend.contains(2)?
                                                      _targetGroupSend.removeWhere((_targetGroup)=> _targetGroup==2)
                                                          :_targetGroupSend.add(2);
                                                    });
                                                  },
                                                ),
                                                CheckedPopupMenuItem(
                                                  checked:_targetGroupShow.contains("إعاقة حركية")?true:false ,
                                                  child: Text("إعاقة حركية"),
                                                  value: "إعاقة حركية",
                                                  onTap: (){
                                                    setState(() {
                                                      _targetGroupShow.contains("إعاقة حركية")?
                                                      _targetGroupShow.removeWhere((_targetGroup)=> _targetGroup=="إعاقة حركية"):
                                                      _targetGroupShow.add("إعاقة حركية");
                                                      _targetGroupSend.contains(3)?
                                                      _targetGroupSend.removeWhere((_targetGroup)=> _targetGroup==3)
                                                          :_targetGroupSend.add(3);
                                                    });
                                                  },
                                                ),
                                                CheckedPopupMenuItem(
                                                  checked:_targetGroupShow.contains("إعاقة إدراكية")?true:false ,
                                                  child: Text("إعاقة إدراكية"),
                                                  value: "إعاقة إدراكية",
                                                  onTap: (){
                                                    setState(() {
                                                      _targetGroupShow.contains("إعاقة إدراكية")?
                                                      _targetGroupShow.removeWhere((_targetGroup)=> _targetGroup=="إعاقة إدراكية"):
                                                      _targetGroupShow.add("إعاقة إدراكية");
                                                      _targetGroupSend.contains(4)?
                                                      _targetGroupSend.removeWhere((_targetGroup)=> _targetGroup==4)
                                                          :_targetGroupSend.add(4);
                                                    });
                                                  },
                                                ),
                                                CheckedPopupMenuItem(
                                                  checked:_targetGroupShow.contains("إعاقة مختلفة(متلازمة دوان الخ..)")?true:false ,
                                                  child: Text("إعاقة مختلفة(متلازمة دوان الخ..)"),
                                                  value: "إعاقة مختلفة(متلازمة دوان الخ..)",
                                                  onTap: (){
                                                    setState(() {
                                                      _targetGroupShow.contains("إعاقة مختلفة(متلازمة دوان الخ..)")?
                                                      _targetGroupShow.removeWhere((_targetGroup)=> _targetGroup=="إعاقة مختلفة(متلازمة دوان الخ..)"):
                                                      _targetGroupShow.add("إعاقة مختلفة(متلازمة دوان الخ..)");
                                                      _targetGroupSend.contains(5)?
                                                      _targetGroupSend.removeWhere((_targetGroup)=> _targetGroup==5)
                                                          :_targetGroupSend.add(5);
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

                                      validatorFun: (value){
                                        if(_targetGroupShow.isEmpty){
                                          isDisabilityTypeError=true;
                                          return "يجب ان تكون ناشط او موثر على الاقل";
                                        }
                                      },
                                      isError: _sendButtonClicked==true?isDisabilityTypeError:false

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
                                      prefixText: "+967 ",
                                      keyboardTypeNum: true,
                                      onChanged: (value){
                                        setState(() {
                                          if((value.startsWith('77')||value.startsWith('78')||value.startsWith('71')||value.startsWith('73')||value.startsWith('70'))&&value.length==9){

                                             isPhoneNumError=false;

                                          }


                                        });
                                      },
                                      validatorFun: (value){
                                        if(value!.isEmpty){
                                          isPhoneNumError=true;
                                          return "يجب عليك ادخال الرقم";
                                        }
                                        else{
                                            if(!(value.startsWith('77')||value.startsWith('78')||value.startsWith('71')||value.startsWith('73')||value.startsWith('70'))||value.length!=9){
                                              isPhoneNumError=true;
                                              return "عليك ادخال الرقم بشكل صحيح";
                                            }
                                            else{
                                              if(value.length<9){
                                                isPhoneNumError=true;
                                                return "عليك ادخال الرقم بشكل صحيح";
                                              }
                                            }

                                          }
                                        }
                                      ,
                                      isError: _sendButtonClicked==true?isPhoneNumError:false
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
            
                      FadeInUp(
                        duration: const Duration(milliseconds: 1100),
                        child: makeInput(
                          rtlDirection: true,
                          hint: "ادخل عنوان السكن",
                          prefixIcon: const Icon(Icons.location_city),
                          context: context,
                          sizeOfScreen: sizeOfScreen,
                          Height: sizeOfScreen.height * 0.1 * 0.75,
                          Width: sizeOfScreen.width > sizeOfScreen.height
                              ? sizeOfScreen.height - 100
                              : double.infinity,
                          label: "عنوان السكن",
                          inputController:_addressController,
                            onChanged:(value){
                              setState(() {
                                if(value.isNotEmpty){
                                  isAddressError=false;
                                }
                                else{
                                  setState(() {
                                    isAddressError=true;
                                  });
                                }
                              });
                            },
                            validatorFun: (value){
                              if(value!.isEmpty){
                                isAddressError=true;
                                return "يجب عليك ادخال عنوان السكن!";
                              }

                            },
                            isError: _sendButtonClicked==true?isAddressError:false
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
                              obscureText: true,
                            onChanged: (value) {
                             setState(() {
                               if(value.isNotEmpty){
                                 isPassError=false;
                                 isConfirmPassError=false;
                               }
                               if(_passController.text==_confirmPassController.text&&value.isNotEmpty){
                                 isPassError=false;
                                 isConfirmPassError=false;
                               }
                               if(_passController.text!=_confirmPassController.text&&value.isNotEmpty){
                                 isPassError=true;
                                 isConfirmPassError=true;
                               }
                               if(value.length>=8){
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
                                  }else{
                                    if(_passController.text!=_confirmPassController.text){
                                      isPassError=true;
                                      return "كلمات المرور غير متطابقة";
                                    }
                                  }
                                }

                            },
                            isError: _sendButtonClicked==true?isPassError:false
                          )
                      ),
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
                              obscureText: true,
                              onChanged: (value) {
                                setState(() {
                                  if(value.isNotEmpty){
                                    isConfirmPassError=false;
                                    isPassError=false;

                                  }
                                  if(_passController.text==_confirmPassController.text&&value.isNotEmpty){
                                    isConfirmPassError=false;
                                    isPassError=false;
                                  }
                                  if(_passController.text!=_confirmPassController.text&&value.isNotEmpty){
                                    isConfirmPassError=true;
                                    isPassError=true;
                                  }
                                  if(value.length>=8){
                                    isConfirmPassError=false;
                                  }

                                });
                              },
                              validatorFun: (value){
                                if(value!.isEmpty){
                                  isConfirmPassError=true;
                                  return "يجب تعبئة الحقل";
                                }
                                else{
                                  if(value.length<8){
                                    isConfirmPassError=true;
                                    return "يجب ان تتكون كلمة المرور على الاقل من 8 احرف";
                                  }

                                  else{
                                    if(_passController.text!=_confirmPassController.text){
                                      isConfirmPassError=true;
                                      return "كلمات المرور غير متطابقة";
                                    }
                                  }
                                }
                              },
                              isError: _sendButtonClicked==true? isConfirmPassError:false
                          )),
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
                            onPressed: () async{

                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return MyCustomLoading();
                                  },);


                                try {
                                  var uri = Uri.parse("http://192.168.43.93:8080/api/register/");
                                  var request = http.MultipartRequest("POST", uri);

                                  // ✅ إضافة الصورة
                                 if(_imageFile!=null){
                                   request.files.add(await http.MultipartFile.fromPath(
                                     'image',
                                     _imageFile!.path,
                                   ));
                                 }

                                  // ✅ إضافة الحقول النصية
                                  request.fields['name'] = _nameController.text;
                                  request.fields['email'] = _emailController.text;
                                  request.fields['phone'] = _phoneNumberController.text;
                                  request.fields['address'] = _addressController.text;
                                  request.fields['password'] = _passController.text;

                                  // ✅ إرسال `List<int>` كـ JSON
                                  for (int i = 0; i < _targetGroupSend.length; i++) {
                                    request.fields['disabilities[$i]'] = _targetGroupSend[i].toString();
                                  }

                                  // ⏳ تنفيذ الطلب وإرسال البيانات
                                  var response = await request.send();

                                  // 📌 قراءة الاستجابة
                                  if (response.statusCode == 200||response.statusCode == 201) {
                                    print("✅ تم رفع البيانات بنجاح!");
                                  //  print(await response.stream.bytesToString());
                                    String responseBody=await response.stream.bytesToString();
                                    try {

                                      Map<String, dynamic> responseData = jsonDecode(responseBody);  // تحويل النص إلى خريطة

                                      // الآن تحويل الخريطة إلى كائن UserRegisterResponse
                                      UserResponseModel userRegisterResponse = UserResponseModel.fromJson(responseData);
                                     setState(() {

                                       CacheHelper.saveData(key: "token", value: "Bearer ${userRegisterResponse.user!.accessToken}");
                                       CacheHelper.saveData(key: "userId", value:userRegisterResponse.data!.userId );
                                       CacheHelper.saveData(key: "name", value:userRegisterResponse.data!.name );
                                       CacheHelper.saveData(key: "image", value:userRegisterResponse.data!.image );
                                       CacheHelper.saveData(key: "email", value:userRegisterResponse.data!.email );
                                       CacheHelper.saveData(key: "address", value:userRegisterResponse.data!.address );
                                       CacheHelper.saveData(key: "phone", value:userRegisterResponse.data!.phone );
                                       CacheHelper.saveData(key: "disabilities", value:userRegisterResponse.data!.disabilities );


                                     });
                                      context.pop();
                                      context.pushReplacement(NavigationScreen());
                                      // طباعة البيانات أو التعامل معها كما تشاء
                                      print("User registered successfully with ID: ${userRegisterResponse.data?.userId}");
                                    } catch (e) {
                                      print("⚠️ حدث خطأ أثناء معالجة البيانات: $e");
                                      showCustomSnackbar
                                        (
                                          textColor: Colors.white,
                                          backgroundColor: Colors.red,
                                          title: "فشل الرفع!!",
                                          subTitle: "حدث خطأ أثناء معالجة البيانات."
                                      );
                                      context.pop();
                                    }


                                  } else {
                                    if(response.statusCode == 400){
                                      showCustomSnackbar
                                            (
                                              textColor: Colors.white,
                                              backgroundColor: Colors.red,
                                              title: "لا يمكن انشاء هذا الحساب! ",
                                              subTitle: "هذا البريد الالكتروني قد تمت اضافته بالفعل."
                                          );
                                      context.pop();
                                    }
                                  else{
                                      print("❌ فشل الرفع: ${response.statusCode}");
                                      print(await response.stream.bytesToString());

                                    }
                                  }

                                } catch (e) {
                                  print("⚠️ حدث خطأ: $e");
                                  showCustomSnackbar
                                         (
                                           textColor: Colors.white,
                                           backgroundColor: Colors.red,
                                           title: "فشل انشاء حساب!",
                                           subTitle: "يبدو ان هناك مشكلة ما او انك غير متصل بالانترنت."
                                       );
                                  context.pop();
                                }


                              } else {
                                _sendButtonClicked=true;
                                autoValidateMode = AutovalidateMode.always;
                                setState(() {});
                              }
                              // SignUpAuth(
                              //     _nameController.text,
                              //     _emailController.text,
                              //     _passController.text
                              // );
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
            
                            context.pushReplacement(LoginScreen(fromWelcompage: widget.fromWelcompage,));
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





