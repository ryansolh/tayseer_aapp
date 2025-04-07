import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_apps/cache/cache_helper.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/core/network/remote/remote_dio.dart';
import 'package:todo_apps/core/utils/app_constants/blog_app_constants.dart';
import 'package:todo_apps/feature/guidances_service/guidances_service.dart';
import 'package:todo_apps/feature/user_login/presention/pages/login_screen.dart';
import 'package:todo_apps/feature/user_login/presention/pages/signup_page.dart';
import 'package:todo_apps/feature/web_view_container/web_view_container_screen.dart';

import '../../feature/account_upgrade_requset/account_upgrade_requset_screen.dart';
import '../../feature/ai_bot/presention/page/bot_screen.dart';
import '../../feature/profile/presention/page/profile_page.dart';
import '../services/confirmed_app_message_sevice/snakbar_message_sevice.dart';
import 'my_custom_linear_gradient.dart';
import 'my_custom_loading.dart';
class MyDrawer extends StatefulWidget {
   MyDrawer({
     Key? key,
      required this.titleOfPage,
     required this.page,
     Widget? bottomNavigationBar,
     this.goBack=false



   }) : _bottomNavigationBar = bottomNavigationBar ;
   Widget? _bottomNavigationBar;

   final bool? goBack;
   final Widget page;
   final String titleOfPage;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
   AdvancedDrawerController _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration:  BoxDecoration(
          gradient: MyLinearGradient,
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(

        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(

        child: Container(

          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/logo_of_app/TAYSEER.png',
                  ),
                ),
                ListTile(
                  onTap: () {
                    context.push(GuidancesServicePage());
                  },
                  leading: const Icon(Icons.question_mark),
                  title: const Text('المرشد المهني'),
                ),
               if(CacheHelper.getData(key: "token")!=null)
                 ListTile(
                   onTap: () {
                     context.push(Profile());
                   },
                   leading: const Icon(Icons.account_circle_rounded),
                   title: const Text('الملف الشخصي'),
                 ),
                if(CacheHelper.getData(key: "role")!="vendor")
                  ListTile(
                    onTap: () {
                     if(CacheHelper.getData(key: "token")!=null){
                       context.push(AccountUpgradeRequsetScreen());
                     }
                     else{
                       showCustomSnackbar
                         (
                           title: "يجب ان يكون لديك حساب",
                           subTitle: "لا يمكن الترقية الا بعد ان يكون لديك حساب لذا يجب ان يكون لديك حساباً اولاً.",
                           textColor: Colors.black
                       );
                       context.push(SignupPage(fromWelcompage: false));
                     }
                    },
                    leading: const Icon(FontAwesomeIcons.crown),
                    title: const Text('ترقية الحساب'),
                  ),
                ListTile(
                  onTap: () {context.push(WebViewScreen());},
                  leading: const Icon(Icons.dashboard),
                  title: const Text('لوحة التحكم'),
                ),
                ListTile(
                  onTap: () {context.push(BotScreen());},
                  leading: const Icon(Icons.question_answer_outlined),
                  title: const Text('مساعد ذكي'),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.sunny),
                  title: const Text('المظهر'),
                ),
                if(CacheHelper.getData(key: "token")==null)
                ListTile(
                  onTap: () {
                    context.push(LoginScreen(fromWelcompage: false,));
                  },
                  leading: const Icon(Icons.login),
                  title: const Text('تسجيل الدخول'),
                ),
                if(CacheHelper.getData(key: "token")!=null)
                  ListTile(
                    onTap: () async{
                      showDialog(
                        context: context,
                        builder: (context) {
                          return MyCustomLoading();
                        },);
                     try{
                       var response= await DioHelper.post(
                           url: logoutUrl,
                           authorization: CacheHelper.getData(key: "token")
                       );
                       if(response.statusCode==200||response.statusCode==201){
                        setState(() {
                          CacheHelper.removeData(key: "token");
                          CacheHelper.removeData(key: "userId");
                          CacheHelper.removeData(key: "name");
                          CacheHelper.removeData(key: "image");
                          CacheHelper.removeData(key: "email");
                          CacheHelper.removeData(key: "address");
                          CacheHelper.removeData(key: "phone");
                          CacheHelper.removeData(key: "disabilities");
                          CacheHelper.removeData(key: "role");
                          CacheHelper.removeData(key: "token2");

                          // CacheHelper.saveData(key: "sentAccountUpgradeRequset", value: CacheHelper.getData(key: "email"));

                        });

                         showCustomSnackbar
                           (
                             title: "✔ تمت العملية",
                             subTitle: "لقد تم تسجيل خروجك بنجاح.",
                           textColor: Colors.black
                         );
                         context.pop();
                       }
                       else{
                         showCustomSnackbar
                           (
                             textColor: Colors.white,
                             backgroundColor: Colors.red,
                             title: "فشل معالجة تسجيل الخروج!!",
                             subTitle: "يبدو ان هناك مشكلة ما او انك غير متصل بالانترنت."
                         );
                         context.pop();
                       }
                     }catch(e){
                       showCustomSnackbar
                         (
                           textColor: Colors.white,
                           backgroundColor: Colors.red,
                           title: "فشل تسجيل الخروج!!",
                           subTitle: "يبدو ان هناك مشكلة ما او انك غير متصل بالانترنت."
                       );
                       context.pop();
                     }

                    },
                    leading: const Icon(Icons.logout_sharp),
                    title: const Text('تسجيل الخروج'),
                  ),
                const Spacer(),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: const Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        appBar: AppBar(
          title:  Text(widget.titleOfPage,
            style: const TextStyle(color: Colors.white, fontFamily: 'Tajawal', fontWeight: FontWeight.bold,),),
          flexibleSpace:
          Container(
            decoration:  BoxDecoration(
              gradient:MyLinearGradient,
            ),
          ),
          leading: IconButton(
            color: Colors.white,
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          actions: [
            widget.goBack==true?
            IconButton(
                onPressed: (){context.pop();},
                icon: Icon(Icons.chevron_right_sharp,
                  size: 40,color: Colors.white,))
          :Container()
          ],
        ),
        body: Container(
          color: Theme.of(context).colorScheme.background,
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              widget.page,
              if(widget._bottomNavigationBar!=null)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding:EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                    child: Container(
                      color: Theme.of(context).colorScheme.background,
                        child: widget._bottomNavigationBar!
                    ),
                  ),

                )
            ],
          ),
        ),

      ),
    );
  }


   void checkIsUserOrVendor()async{
     if(CacheHelper.getData(key: "token")!=null){
       if(CacheHelper.getData(key: "role")!="vendor"){
         try{
           var response=await DioHelper.get(
               url: baseUrl+apiUrl+checkIsvendorRequstUrl,
               authorization: CacheHelper.getData(key: "token")
           );
           if(response.statusCode==200||response.statusCode==201){
             if(response.data["role"].toString()=="vendor"){
               setState((){

                 CacheHelper.removeData(key: "role");
                 CacheHelper.saveData(key: "role", value: "vendor");
               });

             }
           }

         }catch(e){
           print(e);
           if(e.toString().contains("403")){
             setState(() {
               CacheHelper.removeData(key: "role");
               CacheHelper.saveData(key: "role", value: "vendor");
             });
           }
         }
       }
     }
   }

   void _handleMenuButtonPressed() {
     checkIsUserOrVendor();

     _advancedDrawerController.showDrawer();
   }
}
