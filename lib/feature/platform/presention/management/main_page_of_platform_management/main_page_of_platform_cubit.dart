

import 'package:bloc/bloc.dart';

import 'main_page_of_platform_state.dart';

class MainPageOfPlatformCubit extends Cubit<MainPageOfPlatformState> {
  MainPageOfPlatformCubit() : super(ChangeTabBarNumberState());
late int numofPage;
void changePageOfTabBar(int numOfTabBar){
  numofPage=numOfTabBar;
  emit(ChangeTabBarNumberState());
}


}


