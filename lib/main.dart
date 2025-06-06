import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:todo_apps/core/network/remote/remote_dio.dart';
import 'package:todo_apps/feature/web_view_container/web_view_container_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'cache/cache_helper.dart';
import 'core/utils/theme_data/theme_mode.dart';
import 'feature/basic_navigation_page/presention/management/navigation_page_bloc/navigation_page_cubit.dart';
import 'feature/home_page/presention/management/home_screen_bloc/home_screen_cubit.dart';
import 'feature/map/presention/management/map_bloc/map_page_cubit.dart';

import 'feature/market/providers_management/card.dart';
import 'feature/market/providers_management/products.dart';
import 'feature/platform/presention/management/main_page_of_platform_management/main_page_of_platform_cubit.dart';
import 'feature/platform/presention/management/posts_management/blog_app_cubit.dart';
import 'feature/splash_screen/presention/management/splash_screen_bloc/splash_screen_cubit.dart';
import 'feature/splash_screen/presention/pages/splash_screen_page.dart';


void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar', null);
  await CacheHelper.init();
  await DioHelper.init();
  await GetStorage.init();
 // CacheHelper.getData(key: "role");
 // print(CacheHelper.getData(key: "token")) ;
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override

  Widget build(BuildContext context) {
    themeData=LightMode;
   // themeData=DarkMode;



    return MultiProvider(
      providers:[
        BlocProvider(create: (context)=>SplashScreenCubit()),
        BlocProvider(create: (context)=>MapCubit()),
        BlocProvider(create: (context)=>NavigationPageCubit()),
        BlocProvider(create: (context)=>HomeScreenCubit()),
        BlocProvider(create: (context)=>BlogAppPostCubit()),
        BlocProvider(create: (context)=>MainPageOfPlatformCubit()),
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),

      ],
    
      child:GetMaterialApp(

        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const PageOneOfSplashScreen(),
      )
    );
  }
}


/*
providers: [
// ChangeNotifierProvider.value(
//   value: Categories(),
// ),
ChangeNotifierProvider.value(
value: Products(),
),
ChangeNotifierProvider.value(
value: Cart(),
),
ChangeNotifierProvider.value(
value: Orders(),
),
],*/
