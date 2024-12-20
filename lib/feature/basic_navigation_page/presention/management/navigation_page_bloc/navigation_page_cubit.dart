

import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_page_state.dart';

class NavigationPageCubit extends Cubit<NavigationPageState> {
  NavigationPageCubit() : super(OnSelectionState());
int selectedItemIndex=0;
  void onSelectionEvent(int index){
    selectedItemIndex=index;
    emit(OnSelectionState());
  }
}