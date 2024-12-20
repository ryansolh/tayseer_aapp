import 'dart:async';

import 'package:bloc/bloc.dart';

import 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenStete> {
  HomeScreenCubit() : super(onChangeinnerCurrentPageState());
  int innerCurrentPage = 0;
  int outerCurrentPage = 0;


  void onChangeinnerCurrentPage(int innerchangedPage){
    innerCurrentPage=innerchangedPage;
    emit(onChangeinnerCurrentPageState());
  }
  void onChangeouterCurrentPage(int outerchangedPage){
    outerCurrentPage=outerchangedPage;
    emit(onChangeouterCurrentPageState());
  }

}
