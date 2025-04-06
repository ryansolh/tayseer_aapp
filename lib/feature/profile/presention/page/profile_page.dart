
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_apps/cache/cache_helper.dart';
import 'package:todo_apps/core/component/my_custom_image_viewer.dart';
import 'package:todo_apps/core/component/my_custom_shadermask.dart';
import 'package:todo_apps/core/component/my_custom_subtitle.dart';
import 'package:todo_apps/core/utils/app_constants/blog_app_constants.dart';
import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';


class Profile extends StatefulWidget {
 // final Size screenSize;

 // Profile({this.screenSize});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  Animation<double>? fadeAnimation;
  AnimationController? fadeController;
  Animation<double>? editAnimation;
  AnimationController? editController;
  List? disabilities;

  @override
  void initState() {
    disabilities=CacheHelper.getData(key: "disabilities");
    editController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    editAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: editController!,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    fadeController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: fadeController!,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.easeOut,
        )));

    fadeController!.forward();
    super.initState();
  }

  void onPressed() {
    if (editController!.status != AnimationStatus.completed) {
      editController!.forward();
      fadeController!.reverse();
    } else {
      editController!.forward();
      fadeController!.stop();
    }
  }

  void onReverse(){
    if(editController!.status == AnimationStatus.completed){
      fadeController!.reverse();
      editController!.reverse();
     
    }
    else
      {
        fadeController!.forward();
        fadeController!.stop();
      }
  }



  @override
  void dispose() {
    fadeController!.dispose();
    editController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize=MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).colorScheme.background,
          height: screenSize.height,
          width: screenSize.width,
          child: Stack(
            children:[
      
              Column(children:[
                FadeTransition(
                  opacity: fadeAnimation!,
                  child: Container(
                    width:screenSize.width,
                    margin: EdgeInsets.only(bottom: 15.0),
                    child: Stack(children: <Widget>[
                      CustomPaint(
                        painter: ProfileHeader(deviceSize: screenSize),
                      ),
                      Container(
                          width: 150.0,
                          height: 150.0,
                          margin: EdgeInsets.only(
                              left: screenSize.width / 2,
                              top: screenSize.height * 0.1),
                          decoration: new BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 4.0,
                                    offset: Offset(0.0, 03.0)),
                              ],
                              shape: BoxShape.circle,
                             ),
                        child: CacheHelper.getData(key: "image")!=null?CustomImageViewer.show(
                          radius: 100,
                            context: context, url: baseUrl+CacheHelper.getData(key: "image")
                        ):Container(



                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(


                          ),
                          child: Image.asset(
                            'assets/images/logo_of_app/TAYSEER.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
      
                      Container(
                          margin: EdgeInsets.only(
                            
                              top: screenSize.height * 0.15),
                          child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: MySubTitle(
                                      textOfSubTitle: CacheHelper.getData(key: "name")+"\n"+CacheHelper.getData(key: "email"),
                                      textColor: Theme.of(context).colorScheme.background, startDelay: 0),
                                ),
                                // Align(
                                //   alignment: Alignment.topLeft,
                                //   child: MySubTitle(
                                //       textOfSubTitle: CacheHelper.getData(key: "email"),
                                //       textColor: Theme.of(context).colorScheme.background, startDelay: 0),
                                // )

                              ]
                          )
                      ),
                    ]),
                  ),
                ),
                FadeTransition(
                  opacity: fadeAnimation!,
                  child: Container(
                    padding: EdgeInsets.all(screenSize.width * 0.1),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).colorScheme.background,
                              child: MyShaderMask(
                                toolWidget: Icon(Icons.account_circle,size: 35,),
                                radius: 1,
                              ),
                            ),
                            title: Text("الاسم:"),
                            subtitle: Text(CacheHelper.getData(key: "name")),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).colorScheme.background,
                              child: MyShaderMask(
                                toolWidget: Icon(Icons.email,size: 35,),
                                radius: 1,
                              ),
                            ),
                            title: Text("البريد الالكتروني:"),
                            subtitle: Text(CacheHelper.getData(key: "email")),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).colorScheme.background,
                              child: MyShaderMask(
                                toolWidget: Icon(Icons.accessibility_rounded,size: 35,),
                                radius: 1,
                              ),
                            ),
                            title: Text("الفئة:"),
                            subtitle: Text(disabilities!.contains("ليس من ضمن الإعاقة")&&disabilities!.length>1?"ناشط أو مؤثر"+"\n"+"كما ينتمي الى الفئة:${disabilities!.where((disability)=>!disability.contains("ليس من ضمن الإعاقة"))}":disabilities!.contains("ليس من ضمن الإعاقة")?"ناشط أو مؤثر":"ينتمي الى الفئة:${disabilities.toString()}"),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).colorScheme.background,
                              child: MyShaderMask(
                                toolWidget: Icon(Icons.phone,size: 35,),
                                radius: 1,
                              ),
                            ),
                            title: Text("رقم الهاتف:"),
                            subtitle: Text(CacheHelper.getData(key: "phone")),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).colorScheme.background,
                              child: MyShaderMask(
                                toolWidget: Icon(Icons.home,size: 35,),
                                radius: 1,
                              ),
                            ),
                            title: Text("عنوان السكن:"),
                            subtitle: Text(CacheHelper.getData(key: "address")),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
