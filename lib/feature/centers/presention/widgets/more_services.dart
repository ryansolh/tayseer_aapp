

// for calling this tool => floatingActionButton: MoreService().MoreServiceButton(),





import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timezone/tzdata.dart';
import 'package:todo_apps/feature/centers/data/model.dart';
import 'package:todo_apps/feature/centers/presention/widgets/show_map_bottom_sheet.dart';

import '../../../map/presention/page/map_page.dart';
Widget MoreServiceButton(BuildContext context, {  CentersModel? center }) {
  return FabCircularMenu(
    // Cannot be `Alignment.center`
    alignment: Alignment.bottomRight,
    ringColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
    ringDiameter: 500.0,
    ringWidth: 150.0,
    fabSize: 64.0,
    fabElevation: 0,
    fabIconBorder: const CircleBorder(),
    // Also can use specific color based on wether
    // the menu is open or not:
    // fabOpenColor: Colors.white
    // fabCloseColor: Colors.white
    // These properties take precedence over fabColor
    fabColor: const Color(0x9D6CAE),
    fabOpenIcon: const Icon(Icons.more_vert, color: Colors.white,),
    fabCloseIcon: const Icon(Icons.close, color: Colors.white,),
    fabMargin: const EdgeInsets.all(16.0),
    animationDuration: const Duration(milliseconds: 800),
    animationCurve: Curves.easeInOutCirc,
    onDisplayChange: (isOpen) {
      print("The menu is ${isOpen ? "open" : "closed"}");
    },
    children: <Widget>[
      RawMaterialButton(
        onPressed: () {
          print("You pressed 1");
        },
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(24.0),
        child: const Icon(Icons.looks_one, color: Colors.grey),
      ),
      RawMaterialButton(
        onPressed: () {
          print("You pressed 2");
        },
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(24.0),
        child: const Icon(Icons.looks_two, color: Colors.grey),
      ),
      RawMaterialButton(
        onPressed: () {
          print("You pressed 3");
        },
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(24.0),
        child: const Icon(Icons.call, color: Colors.grey),
      ),
      RawMaterialButton(
        onPressed: () {
         showModalBottomSheet(
           shape: const RoundedRectangleBorder(borderRadius:BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20) ) ),
             context: context,
             builder: (context){
               return Container(
                 color: Theme.of(context).colorScheme.background,
                 height: MediaQuery.of(context).size.height-100,
                 width: double.infinity,
                 child:  MapScreen(centerLocation:center!.location),
               );
             }
         );
        },
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(24.0),
        child:const Icon(Icons.map,color: Colors.grey,),
      )
    ],
  );


}


