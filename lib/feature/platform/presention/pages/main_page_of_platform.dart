/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (index) {
              print(index);
            },
            labelStyle: TextStyle(fontSize: 16),
            indicatorColor: Colors.blue,
            physics: BouncingScrollPhysics(),
            labelColor: Theme.of(context).textTheme.labelSmall!.color,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.mark_unread_chat_alt_sharp,
                      color: Theme.of(context).textTheme.labelSmall!.color,
                    ),
                    SizedBox(width: 5,),
                    Text(
                      'المنشورات',
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.insert_drive_file,
                      color: Theme.of(context).textTheme.labelSmall!.color,
                    ),
                    SizedBox(width: 5,),
                    Text(
                      'Article',
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.supervised_user_circle,
                      color: Theme.of(context).textTheme.labelSmall!.color,
                    ),
                    SizedBox(width: 5,),
                    Text(
                      'User',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Home',

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
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Articles',

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
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              width: width,
              child: Column(
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
      ),
    );
  }
}
*/
