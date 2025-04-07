import 'dart:convert';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_apps/cache/cache_helper.dart';
import 'package:todo_apps/core/component/my_custom_buttons.dart';
import 'package:todo_apps/core/component/my_custom_drawer.dart';
import 'package:todo_apps/core/component/my_custom_subtitle.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';

import 'package:http/http.dart' as http;
import '../../core/component/input_widget.dart';
import '../../core/component/my_custom_loading.dart';
import '../../core/component/my_custom_shadermask.dart';
import '../../core/services/confirmed_app_message_sevice/snakbar_message_sevice.dart';
class AccountUpgradeRequsetScreen extends StatefulWidget {
   AccountUpgradeRequsetScreen({super.key});

  @override
  State<AccountUpgradeRequsetScreen> createState() => _AccountUpgradeRequsetScreenState();
}

class _AccountUpgradeRequsetScreenState extends State<AccountUpgradeRequsetScreen> {
  TextEditingController _walletNumber=TextEditingController();
  String walletType="جوالي";
  String frontPhotoOfIDCardPath='';
  String backPhotoOfIDCardPath='';
  String personWithIDCardPhotoPath='';
  File? frontPhotoOfIDCard;
  File? backPhotoOfIDCard;
  File? personWithIDCardPhoto;

  final _picker = ImagePicker();
  Future getImage(int imageNum) async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null){
      setState(() {
        if(imageNum==1){
          frontPhotoOfIDCard = File(pickedFile.path);
        frontPhotoOfIDCardPath=pickedFile.path;
        }
        else if(imageNum==2){
          backPhotoOfIDCard = File(pickedFile.path);
          backPhotoOfIDCardPath=pickedFile.path;
        }
        else{
          personWithIDCardPhoto = File(pickedFile.path);
          personWithIDCardPhotoPath=pickedFile.path;
        }

      });
    }
  }
  String? getStringImage(File? file) {

    if (file == null) return null ;
    return base64Encode(file.readAsBytesSync());
  }

  void sendAccountUpgradeRequest()async{
    showDialog(
      context: context,
      builder: (context) {
        return MyCustomLoading();
      },);
    try{
      var uri = Uri.parse("http://192.168.43.93:8080/api/vendor-request");
      var request = http.MultipartRequest("POST", uri);
      request.headers.addAll({
        'Authorization': CacheHelper.getData(key: "token"), // تنسيق شائع لـ Bearer tokens
        'Content-Type': 'multipart/form-data', // تأكد من وجود هذا الهيدر لـ MultipartRequest
      });
      request.fields['wallet_type']=walletType;
      request.fields['account_number']=_walletNumber.text;
      request.files.add(await http.MultipartFile.fromPath('id_front', frontPhotoOfIDCard!.path));
      request.files.add(await http.MultipartFile.fromPath('id_back', backPhotoOfIDCard!.path));
      request.files.add(await http.MultipartFile.fromPath('selfie_with_id', personWithIDCardPhoto!.path));
      var response=await request.send();

      if(response.statusCode==200||response.statusCode==201){
        showCustomSnackbar
          (
            title: "تم ارسال الطلب بنجاح",
            subTitle: "نشكرك على طلبك. تم تسجيل طلبك بنجاح وسنقوم بمراجعته. \n سنبقيك على اطلاع دائم بحالة طلب ترقيتك.",
            textColor: Colors.black
        );
        CacheHelper.removeData(key: "sentAccountUpgradeRequset");
        CacheHelper.saveData(key: "sentAccountUpgradeRequset", value: CacheHelper.getData(key: "email"));
        context.pop();
        context.pop();
      }


    }
    catch(e){
      print(e);
      showCustomSnackbar
        (
          title: "فشل ارسال الطلب!",
          subTitle: "يبدو ان اتصالك بالانترنت منقطع او قد يكون ضعيف.",
          textColor: Colors.black
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size sizeOfScreen=MediaQuery.of(context).size;
    double _hight=MediaQuery.of(context).size.height;
    double _width=MediaQuery.of(context).size.width;
    return MyDrawer(
        titleOfPage: "طلب ترقية الحساب",
        page: Container(
          height:_hight ,
          width: _width,
          color: Theme.of(context).colorScheme.background,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MySubTitle(
                      textOfSubTitle: "قم بادخال البيانات اللازمة لترقية الحساب",
                      startDelay: 0
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: makeInput(
                        readOnly: true,
                        hint: walletType,
                        prefixIcon: MyShaderMask(
                            toolWidget:  PopupMenuButton<String>(
                              enableFeedback: false,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              color: Theme.of(context).colorScheme.background,
                              // color: Get.isDarkMode ? darkGreyColor : Colors.white,
                              icon: const Icon(Icons.more_vert_sharp,color: Colors.grey,),
                              padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),

                              onSelected: (value){
                                setState(() {
                                  walletType=value;
                                });
                              },
                              itemBuilder: (BuildContext context) {

                                return [
                                  const PopupMenuItem(
                                    value: "جوالي",
                                    child: Align(
                                        alignment: Alignment.topRight,
                                        child: Text("جوالي")
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: "فلوسك",
                                    child: Align(
                                        alignment: Alignment.topRight,
                                        child: Text("فلوسك")
                                    ),
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
                        label: "نوع المحفظة",

                        /*validatorFun: (value){
                          if(_targetGroupShow.isEmpty){
                            isDisabilityTypeError=true;
                            return "يجب ان تكون ناشط او موثر على الاقل";
                          }
                        },*/
                        isError: false

                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 700),
                    child: makeInput(
                      inputController: _walletNumber,
                        hint: "ادخل رقم المحفظة",
                        prefixIcon: MyShaderMask(
                            toolWidget: Icon(Icons.wallet),
                            radius: 1.3
                        ),
                        context: context,
                        sizeOfScreen: sizeOfScreen,
                        Height: sizeOfScreen.height * 0.1 * 0.75,
                        Width: sizeOfScreen.width > sizeOfScreen.height
                            ? sizeOfScreen.height - 100
                            : double.infinity,
                        label: "رقم المحفظة",

                        /*validatorFun: (value){
                          if(_targetGroupShow.isEmpty){
                            isDisabilityTypeError=true;
                            return "يجب ان تكون ناشط او موثر على الاقل";
                          }
                        },*/
                        isError: false

                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 900),
                    child: makeInput(
                        readOnly: true,
                        hint: frontPhotoOfIDCardPath,
                        prefixIcon: IconButton(
                          onPressed: (){
                            getImage(1);
                          },
                          icon: Icon(Icons.image),
                        ),
                        context: context,
                        sizeOfScreen: sizeOfScreen,
                        Height: sizeOfScreen.height * 0.1 * 0.75,
                        Width: sizeOfScreen.width > sizeOfScreen.height
                            ? sizeOfScreen.height - 100
                            : double.infinity,
                        label: "الصورة الامامية للبطاقة",

                        /*validatorFun: (value){
                          if(_targetGroupShow.isEmpty){
                            isDisabilityTypeError=true;
                            return "يجب ان تكون ناشط او موثر على الاقل";
                          }
                        },*/
                        isError: false

                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1100),
                    child: makeInput(
                        readOnly: true,
                        hint: backPhotoOfIDCardPath,
                        prefixIcon: IconButton(
                          onPressed: (){
                            getImage(2);
                          },
                          icon: Icon(Icons.image),
                        ),
                        context: context,
                        sizeOfScreen: sizeOfScreen,
                        Height: sizeOfScreen.height * 0.1 * 0.75,
                        Width: sizeOfScreen.width > sizeOfScreen.height
                            ? sizeOfScreen.height - 100
                            : double.infinity,
                        label: "الصورة الخلفية للبطاقة",

                        /*validatorFun: (value){
                          if(_targetGroupShow.isEmpty){
                            isDisabilityTypeError=true;
                            return "يجب ان تكون ناشط او موثر على الاقل";
                          }
                        },*/
                        isError: false

                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1300),
                    child: makeInput(
                        readOnly: true,
                        hint: personWithIDCardPhotoPath,
                        prefixIcon: IconButton(
                          onPressed: (){
                            getImage(3);
                          },
                          icon: Icon(Icons.image),
                        ),
                        context: context,
                        sizeOfScreen: sizeOfScreen,
                        Height: sizeOfScreen.height * 0.1 * 0.75,
                        Width: sizeOfScreen.width > sizeOfScreen.height
                            ? sizeOfScreen.height - 100
                            : double.infinity,
                        label: "صورتك سلفي مع البطاقة",

                        /*validatorFun: (value){
                          if(_targetGroupShow.isEmpty){
                            isDisabilityTypeError=true;
                            return "يجب ان تكون ناشط او موثر على الاقل";
                          }
                        },*/
                        isError: false

                    ),
                  ),
                  40.SH,
                  FadeInUp(
                    duration: const Duration(milliseconds: 1500),
                    child: MyButtonWithBackground(
                        context: context,
                      textButton: "ارسال الطلب",
                      onPressed: (){
                         if(CacheHelper.getData(key: "sentAccountUpgradeRequset")!=CacheHelper.getData(key: "email")){
                           if(_walletNumber.text.isEmpty){
                             showCustomSnackbar
                               (
                                 backgroundColor: Colors.red,
                                 title: "",
                                 subTitle: "يجب عليك كتابة رقم المحفظة",
                                 textColor: Colors.white
                             );
                           }else{
                             if(frontPhotoOfIDCardPath.isEmpty){
                               showCustomSnackbar
                                 (
                                   backgroundColor: Colors.red,
                                   title: "",
                                   subTitle: "يجب ادخال الصورة الامامية للبطاقة",
                                   textColor: Colors.white
                               );
                             }
                             else{
                               if(backPhotoOfIDCardPath.isEmpty){
                                 showCustomSnackbar
                                   (
                                     backgroundColor: Colors.red,
                                     title: "",
                                     subTitle: "يجب ادخال الصورة الخلفية للبطاقة",
                                     textColor: Colors.white
                                 );
                               }else{
                                 if(personWithIDCardPhotoPath.isEmpty){
                                   showCustomSnackbar
                                     (
                                       backgroundColor: Colors.red,
                                       title: "",
                                       subTitle: "يجب ادخال صورتك سلفي مع البطاقة",
                                       textColor: Colors.white
                                   );
                                 }
                                 else{
                                   sendAccountUpgradeRequest();
                                 }
                               }
                             }
                           }
                         }
                         else{
                         if(  CacheHelper.getData(key: "sentAccountUpgradeRequset")==  CacheHelper.getData(key: "email")){
                           showCustomSnackbar
                             (
                               title: "لا يمكن ارسال اكثر من طلب",
                               subTitle: "لقد قم بارسال طلب ترقية حساب من قبل من قبل!",
                               textColor: Colors.black
                           );
                         }

                         }

                      }

                    ),
                  )

                ],
              ),
            ),
          ),

        )
    );
  }
}
