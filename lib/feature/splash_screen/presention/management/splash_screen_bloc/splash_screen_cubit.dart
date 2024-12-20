import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_screen_states.dart';


class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(Timer_aState());
  bool firstAnimationTimer = false;
  bool secondAnimationTimer = false;
  bool thirdAnimationTimer = false;
  bool fourthAnimationTimer = false;
  bool fifthAnimationTimer = false;


  // ignore: non_constant_identifier_names
  void StartingPageOneOfSplashScreen(){
    Timer(const Duration(milliseconds: 100), () {
      emit(NavigationToPageTwoOfSplashScreenState());

    });
  }
  // ignore: non_constant_identifier_names
  void StartingAnimationTimersOfSplashScreen(){
    Timer(const Duration(milliseconds: 400), () {
      firstAnimationTimer=true;
      emit(Timer_aState());
    });


    Timer(const Duration(milliseconds: 400), () {
      secondAnimationTimer=true;
      emit(Timer_bState());
    });


    Timer(const Duration(milliseconds: 1300), () {
      thirdAnimationTimer=true;
      emit(Timer_cState());
    });


    Timer(const Duration(milliseconds:0), () {
      fifthAnimationTimer=true;
      emit(Timer_eState());
    });


    Timer(const Duration(milliseconds: 3400), () {
      fourthAnimationTimer=true;
      emit(Timer_dState());
    });


    Timer(const Duration(milliseconds: 4200), () {
      emit(NavigationToOnBoardingPagesState());
    });


  }

}