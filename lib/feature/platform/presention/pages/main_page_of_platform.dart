import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_apps/core/component/my_custom_shadermask.dart';
import 'package:todo_apps/feature/platform/data/editing_post_data.dart';
import 'package:todo_apps/feature/platform/presention/pages/posts_data_screen.dart';

import '../management/main_page_of_platform_management/main_page_of_platform_cubit.dart';
import '../management/main_page_of_platform_management/main_page_of_platform_state.dart';
import 'add_and_edit_post_page.dart';

class MainPageOfPlatform extends StatefulWidget {
  //static String tag = "/DemoMWTabBarScreen2";

  @override
  _MainPageOfPlatformState createState() => _MainPageOfPlatformState();
}

class _MainPageOfPlatformState extends State<MainPageOfPlatform> {
final TextEditingController postContentController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    BlocProvider.of<MainPageOfPlatformCubit>(context).changePageOfTabBar(0);
    return DefaultTabController(
      length: 3,
      child:BlocConsumer<MainPageOfPlatformCubit,MainPageOfPlatformState>(
          builder: (context,state){
            return  Container(
              color: Theme.of(context).colorScheme.background,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                    child: Row(
                      children: [

                        Expanded(
                          child: TextFormField(
                            cursorColor: Colors.grey.withOpacity(0.4),
                            autofocus: false,
                            style: TextStyle(color: Theme.of(context).textTheme.labelSmall!.color),
                            onChanged: (value) {
                              //filterSearchResults(value);
                            },
                            controller: postContentController,
                            decoration: InputDecoration(
                                hintText: "Search Store",
                                filled: true,
                                fillColor: Theme.of(context).colorScheme.background,
                                hoverColor: Theme.of(context).colorScheme.background.withOpacity(0.1),
                                focusColor: Theme.of(context).colorScheme.background.withOpacity(0.1),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                prefixIcon: MyShaderMask(
                                  toolWidget: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                  radius: 1.3,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(25.0)
                                    )
                                )
                            ),

                          ),
                        ),

                        MyShaderMask(
                            toolWidget:  IconButton(
                                onPressed: (){


                                },
                                icon: Icon(Icons.shopping_cart_checkout)
                            ),
                            radius: 1.3
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PostsDataScreen(),
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
