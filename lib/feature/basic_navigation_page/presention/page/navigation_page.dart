import 'package:bottom_bar_matu/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_apps/core/component/my_custom_loading.dart';
import 'package:todo_apps/core/network/remote/remote_dio.dart';
import 'package:todo_apps/core/utils/app_constants/blog_app_constants.dart';
import 'package:todo_apps/feature/reminder/presention/pages/alarm_page.dart';
import '../../../../cache/cache_helper.dart';
import '../../../../core/component/my_custom_drawer.dart';
import '../../../centers/presention/pages/main_page_of_centers_list.dart';
import '../../../home_page/presention/page/home_screen.dart';
import '../../../market/presention/page/explore/explore_screen.dart';
import '../../../platform/presention/pages/posts_data_screen.dart';
import '../management/navigation_page_bloc/navigation_page_cubit.dart';
import '../management/navigation_page_bloc/navigation_page_state.dart';
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {



List<Widget> _pages=[
  HomeScreen(),
  MyCustomLoading(),
  MyCustomLoading(),
  MyCustomLoading(),
  MyCustomLoading(),
];


final List<String> _titles = [
  'الصفحة الرئيسية',
  'المنبه',
  'المراكز',
  'المتجر',
  'المنشورات'
];

List<int> indexesOfPages=[
  0,
];

void checkIsUserOrVendor()async{
 if(CacheHelper.getData(key: "token")!=null){
   if(CacheHelper.getData(key: "role")!="vendor"){
     try{
       var response=await DioHelper.get(
           url: baseUrl+apiUrl+checkIsvendorRequstUrl,
               authorization: CacheHelper.getData(key: "token")
       );
       if(response.statusCode==200||response.statusCode==201){
         if(response.data["role"].toString()=="vendor"){
           setState((){

             CacheHelper.removeData(key: "role");
             CacheHelper.saveData(key: "role", value: "vendor");
           });

         }
       }

     }catch(e){
       print(e);
       if(e.toString().contains("403")){
        setState(() {
          CacheHelper.removeData(key: "role");
          CacheHelper.saveData(key: "role", value: "vendor");
        });
       }
     }
   }
 }
}


void _savingPagesStateAfterShowingOnTime(int index){
  if(index==1){
    checkIsUserOrVendor();

    if(indexesOfPages.contains(1)==false){
      setState(() {
        _pages[index]=AlarmPage();
        indexesOfPages.add(1);
      });
    }
  }
  if(index==2){
    if(indexesOfPages.contains(2)==false){
      setState(() {
        _pages[index]=MainPageOfCentersList();
        indexesOfPages.add(2);
      });
    }
  }
  if(index==3){
    if(indexesOfPages.contains(3)==false){
      setState(() {
        _pages[index]=ExploreScreen();
        indexesOfPages.add(3);
      });
    }
  }
  if(index==4){
    if(indexesOfPages.contains(4)==false){
      setState(() {
        _pages[index]=PostsDataScreen();
        indexesOfPages.add(4);
      });
    }
  }
}


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NavigationPageCubit>(context).onSelectionEvent(0);
  }

 @override
  Widget build(BuildContext context) {
   Size size=MediaQuery.of(context).size;
   List<BottomBarItem> bottomBarItemItems=[
     BottomBarItem(iconData: Icons.home,),
     BottomBarItem(iconData: Icons.share_arrival_time_sharp),
     BottomBarItem(iconData: Icons.home_work_rounded),
     BottomBarItem(iconData: Icons.shopping_cart),
     BottomBarItem(iconData: Icons.amp_stories_outlined,),
   ];





    return BlocConsumer<NavigationPageCubit,NavigationPageState>(
      listener: (context,state){

      },
      builder: (context,state){
        int indexOfSelection=BlocProvider.of<NavigationPageCubit>(context).selectedItemIndex;
        return MyDrawer(
          titleOfPage: _titles[indexOfSelection],
          page: IndexedStack(
            index: indexOfSelection,
            children: _pages,
          ),
          bottomNavigationBar:BottomBarDoubleBullet(

            bubbleSize: 15,
            backgroundColor: Theme.of(context).colorScheme.background,
            circle1Color: const Color(0xFF9D6CAE),
            circle2Color: const Color(0xFF75B6E3),
            // margin_value: size.width * .02,
            selectedIndex:indexOfSelection,
            items: bottomBarItemItems,
            onSelect: (index) async{
              print("//");
              print(index);

              _savingPagesStateAfterShowingOnTime(index);



              BlocProvider.of<NavigationPageCubit>(context).onSelectionEvent(index);
              indexOfSelection=BlocProvider.of<NavigationPageCubit>(context).selectedItemIndex;
            }, margin_value: 0,
          ),
        );
      },
    );
  }
}




//
// AlarmPage(),
// MainPageOfCentersList(),
// ExploreScreen(),
// PostsDataScreen()
















/*
import 'package:bottom_bar_matu/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_apps/feature/reminder/presention/pages/alarm_page.dart';
import '../../../../core/component/my_custom_drawer.dart';
import '../../../centers/presention/pages/main_page_of_centers_list.dart';
import '../../../home_page/presention/page/home_screen.dart';
import '../../../market/presention/page/explore_screen.dart';
import '../../../platform/presention/pages/posts_data_screen.dart';
import '../management/navigation_page_bloc/navigation_page_cubit.dart';
import '../management/navigation_page_bloc/navigation_page_state.dart';
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {






  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    List<BottomBarItem> bottomBarItemItems=[
      BottomBarItem(iconData: Icons.home,),
      BottomBarItem(iconData: Icons.share_arrival_time_sharp),
      BottomBarItem(iconData: Icons.home_work_rounded),
      BottomBarItem(iconData: Icons.shopping_cart),
      BottomBarItem(iconData: Icons.amp_stories_outlined,),
    ];



    return BlocConsumer<NavigationPageCubit,NavigationPageState>(
      listener: (context,state){

      },
      builder: (context,state){
        int indexOfSelection=BlocProvider.of<NavigationPageCubit>(context).selectedItemIndex;
        return MyDrawer(
          titleOfPage: indexOfSelection==0?'الصفحة الرئيسية':indexOfSelection==1?"المنبه":indexOfSelection==2?
          "المراكز":indexOfSelection==3?"المتجر":"المنشورات",
          page: indexOfSelection==0? const HomeScreen():indexOfSelection==1?
          const AlarmPage():indexOfSelection==2? const MainPageOfCentersList():indexOfSelection==3? ExploreScreen():PostsDataScreen(),
          bottomNavigationBar:BottomBarDoubleBullet(

            bubbleSize: 15,
            backgroundColor: Theme.of(context).colorScheme.background,
            circle1Color: const Color(0xFF9D6CAE),
            circle2Color: const Color(0xFF75B6E3),
            // margin_value: size.width * .02,
            selectedIndex:indexOfSelection,
            items: bottomBarItemItems,
            onSelect: (index) {
              BlocProvider.of<NavigationPageCubit>(context).onSelectionEvent(index);
              indexOfSelection=BlocProvider.of<NavigationPageCubit>(context).selectedItemIndex;
            }, margin_value: 0,
          ),
        );
      },
    );
  }
}
*/
