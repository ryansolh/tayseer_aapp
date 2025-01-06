import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/db/db.helper.dart';
import 'core/utils/theme_data/theme_mode.dart';
import 'feature/basic_navigation_page/presention/management/navigation_page_bloc/navigation_page_cubit.dart';
import 'feature/home_page/presention/management/home_screen_bloc/home_screen_cubit.dart';
import 'feature/map/presention/management/map_bloc/map_page_cubit.dart';
import 'feature/splash_screen/presention/management/splash_screen_bloc/splash_screen_cubit.dart';
import 'feature/splash_screen/presention/pages/splash_screen_page.dart';


void main() async{
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar',null);
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override

  Widget build(BuildContext context) {
    themeData=LightMode;
   // themeData=DarkMode;



    return MultiBlocProvider(
      providers:[
        BlocProvider(create: (context)=>SplashScreenCubit()),
        BlocProvider(create: (context)=>MapCubit()),
        BlocProvider(create: (context)=>NavigationPageCubit()),
        BlocProvider(create: (context)=>HomeScreenCubit()),
      ],

      child:MaterialApp(

        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const PageOneOfSplashScreen(),
      )
    );
  }
}


