import 'package:bottom_bar_matu/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_apps/feature/otherpages/page4.dart';
import 'package:todo_apps/feature/reminder/presention/pages/alarm_page.dart';
import '../../../../core/component/my_custom_drawer.dart';
import '../../../centers/presention/pages/main_page_of_centers_list.dart';
import '../../../home_page/presention/page/home_screen.dart';
import '../../../platform/presention/pages/posts_screen.dart';
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
     BottomBarItem(iconData: Icons.calendar_month),
     BottomBarItem(iconData: Icons.amp_stories_outlined,),
   ];

    return BlocConsumer<NavigationPageCubit,NavigationPageState>(
      listener: (context,state){

      },
      builder: (context,state){
        int indexOfSelection=BlocProvider.of<NavigationPageCubit>(context).selectedItemIndex;
        return MyDrawer(
          titleOfPage: indexOfSelection==0?'الصفحة الرئيسية':indexOfSelection==1?"المنبه":indexOfSelection==2?
          "المراكز":indexOfSelection==3?"الصفحة الرابعة":"المنشورات",
          page: indexOfSelection==0? const HomeScreen():indexOfSelection==1?
          const AlarmPage():indexOfSelection==2? const MainPageOfCentersList():indexOfSelection==3? const Page4():PostsPage(),
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
