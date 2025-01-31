import 'package:flutter/material.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';

import '../../core/component/my_custom_linear_gradient.dart';

class GuidancesServicePage extends StatelessWidget {
  const GuidancesServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text("المرشد المهني",
          style: TextStyle(color: Colors.white, fontFamily: 'Tajawal', fontWeight: FontWeight.bold,),),
        leading: Container(),
        actions: [
          IconButton(
            onPressed: (){context.pop();},
            icon: Icon(Icons.chevron_right_sharp,
              size: 40,color: Colors.white,
            )
          )
        ],
        flexibleSpace:
        Container(
          decoration:  BoxDecoration(
            gradient:MyLinearGradient,
          ),
        ),

      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: Text("سيتوفر قريباً"),
        ),
      ),
    );
  }
}
