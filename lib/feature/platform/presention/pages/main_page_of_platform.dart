import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_apps/core/component/my_custom_shadermask.dart';
import 'package:todo_apps/feature/platform/presention/pages/posts_screen.dart';

import '../management/main_page_of_platform_management/main_page_of_platform_cubit.dart';
import '../management/main_page_of_platform_management/main_page_of_platform_state.dart';
import 'add_and_edit_post_page.dart';

class MainPageOfPlatform extends StatefulWidget {
  //static String tag = "/DemoMWTabBarScreen2";

  @override
  _MainPageOfPlatformState createState() => _MainPageOfPlatformState();
}

class _MainPageOfPlatformState extends State<MainPageOfPlatform> {
  @override
  void initState() {
    super.initState();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    BlocProvider.of<MainPageOfPlatformCubit>(context).changePageOfTabBar(0);
    return DefaultTabController(
      length: 3,
      child:BlocConsumer<MainPageOfPlatformCubit,MainPageOfPlatformState>(
          builder: (context,state){
            return  Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.background,
                title: TabBar(
                  //automaticIndicatorColorAdjustment: false,

                  onTap: (index) {
                    BlocProvider.of<MainPageOfPlatformCubit>(context).changePageOfTabBar(index);
                    print(index);
                  },

                  labelStyle: const TextStyle(fontSize: 16),
                  indicatorColor: const Color(0xFF75B6E3),
                  physics: const BouncingScrollPhysics(),
                  labelColor: Theme.of(context).textTheme.labelSmall!.color,
                  tabs: [
                    state is ChangeTabBarNumberState && BlocProvider.of<MainPageOfPlatformCubit>(context).numofPage==0?
                    const Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [

                        MyShaderMask(
                            toolWidget:  Icon(Icons.mark_unread_chat_alt_sharp, color: Colors.grey,),
                            radius: 1),
                          SizedBox(width: 5,),
                          /*MyShaderMask(
                              toolWidget: Text('المنشورات')
                              , radius: 3)*/
                        ],
                      ),
                    ):const Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Icon(Icons.mark_unread_chat_alt_sharp, color: Colors.grey,),
                        SizedBox(width: 5,),
                        /*Text(
                          'المنشورات',
                        ),*/
                      ],
                    ),
                  ),
                  state is ChangeTabBarNumberState && BlocProvider.of<MainPageOfPlatformCubit>(context).numofPage==1?
                const Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      MyShaderMask(
                          toolWidget:  Icon(Icons.add_circle_sharp, color: Colors.grey,),
                          radius: 1),
                      SizedBox(width: 5,),
                      /*MyShaderMask(
                          toolWidget: Text('اضافة منشور')
                          , radius: 3)*/
                    ],
                  ),
                ):const Tab(
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [

                  Icon(Icons.add_circle_sharp, color: Colors.grey,),
                  SizedBox(width: 5,),
                  /*Text(
                    'اضافة منشور',
                  ),*/
                ],
              ),
            ),
                    state is ChangeTabBarNumberState && BlocProvider.of<MainPageOfPlatformCubit>(context).numofPage==2?
                    const Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          MyShaderMask(
                              toolWidget:  Icon(Icons.account_box_outlined, color: Colors.grey,),
                              radius: 1),
                          SizedBox(width: 5,),
                         /* MyShaderMask(
                              toolWidget: Text('الملف الشخصي')
                              , radius: 3)*/
                        ],
                      ),
                    ):const Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Icon(Icons.account_box_outlined, color: Colors.grey,),
                          SizedBox(width: 5,),
                         /* Text(
                            'الملف الشخصي',
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
                automaticallyImplyLeading: false,

              ),
              body: TabBarView(
                children: [
                  PostsPage(),
                  PostForm(),
                  Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    width: width,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'User',

                        ),
                        SizedBox(height: 15,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          listener: (context,state){

          }
      ),
    );
  }
}
