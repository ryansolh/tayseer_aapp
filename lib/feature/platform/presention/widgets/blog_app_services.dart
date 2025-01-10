

// for calling this tool => floatingActionButton: MoreService().MoreServiceButton(),





import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';




Widget MoreServiceButtonOfBlogApp(BuildContext context,) {
  return FabCircularMenu(
    // Cannot be `Alignment.center`
    alignment: Alignment.bottomRight,
    ringColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
    ringDiameter: 500.0,
    ringWidth: 150.0,
    fabSize: 64.0,
    fabElevation: 0,
    fabIconBorder: CircleBorder(),
    // Also can use specific color based on wether
    // the menu is open or not:
    // fabOpenColor: Colors.white
    // fabCloseColor: Colors.white
    // These properties take precedence over fabColor
    fabColor: Color(0x9D6CAE),
    fabOpenIcon: Icon(Icons.more_vert, color: Colors.white,),
    fabCloseIcon: Icon(Icons.close, color: Colors.white,),
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
        shape: CircleBorder(),
        padding: const EdgeInsets.all(24.0),
        child: Icon(Icons.account_box_outlined, color: Colors.grey),
      ),

      RawMaterialButton(
        onPressed: () {

        },
        shape: CircleBorder(),
        padding: const EdgeInsets.all(24.0),
        child:Icon(Icons.add_circle_sharp,color: Colors.grey,),
      ),
      RawMaterialButton(
        onPressed: () {

        },
        shape: CircleBorder(),
        padding: const EdgeInsets.all(24.0),
        child:Icon(Icons.add_circle_sharp,color: Colors.grey,),
      )
    ],
  );


}


