


// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';

ThemeData themeData= ThemeData();



ThemeData DarkMode=ThemeData(
    brightness: Brightness.light,
    colorScheme:  ColorScheme.fromSeed(
      background:Color(0xFF2C2929),
      onBackground:Colors.black87,
      secondary:Colors.white70,
      seedColor: Colors.deepPurpleAccent,


    ),
    textTheme: TextTheme(
      labelSmall: TextStyle(
        color: Colors.grey[500],
        fontFamily: 'Tajawal',
        fontSize: 16,

      ),

      labelMedium: const TextStyle(
        color: Colors.white70,
        fontFamily: 'Tajawal',
        fontWeight: FontWeight.normal,
        fontSize: 16,),

    )
);


ThemeData LightMode=ThemeData(

    brightness: Brightness.light,
    fontFamily: 'Tajawal',
    colorScheme:  ColorScheme.fromSeed(
      background: Colors.white,
      onBackground:Colors.white70,
      secondary:Colors.black87,
      seedColor: Colors.deepPurpleAccent,



    ),

    textTheme: TextTheme(
      labelSmall: TextStyle(
        color: Colors.grey[700],
        fontFamily: 'Tajawal',
        fontWeight: FontWeight.w600,
        letterSpacing: 0,


        fontSize:16 ,


      ),
      labelMedium: const TextStyle(
        color: Colors.black87,
        fontFamily: 'Tajawal',
        fontWeight: FontWeight.normal,
        fontSize: 16,),
    ),

);