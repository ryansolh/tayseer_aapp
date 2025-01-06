import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:todo_apps/core/component/my_custom_buttons.dart';
import 'package:todo_apps/core/component/my_custom_image_viewer.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/feature/centers/data/model.dart';
import 'package:todo_apps/feature/centers/presention/widgets/more_services.dart';

import '../../../../core/component/my_custom_linear_gradient.dart';
import '../../../map/presention/management/map_bloc/map_page_cubit.dart';
import '../../../map/presention/management/map_bloc/map_page_states.dart';
import '../widgets/center_description.dart';

//import 'package:untitled2/widgets/details/counter_with_fav_btn.dart';

//import '../widgets/details/cart_counter.dart';
const kDefaultPadding = 20.0;
const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

class CenterDetailsScreen extends StatelessWidget {
  final CentersModel? center;

  const CenterDetailsScreen({Key? key, this.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title:   Text(center!.name,
          style: TextStyle(color: Colors.white, fontFamily: 'Tajawal', fontWeight: FontWeight.bold,),),
        leading: Container(),
        actions: [IconButton(onPressed: (){context.pop();}, icon: Icon(Icons.chevron_right_sharp,size: 40,color: Colors.white,))],
        flexibleSpace:
        Container(
          decoration:  BoxDecoration(
            gradient:MyLinearGradient,
          ),
        ),

      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: size.height,
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: "${center!.id}",
                      child: Container(
                        height: MediaQuery.of(context).size.height/2.7,
                        width:MediaQuery.of(context).size.width ,
                        // height: size.height * 0.3,
                        child: CustomImageViewer.show(
                          radius: 0,
                            context: context,
                            url: center!.imageUrl
                        )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height/2.8),

                      // height: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          20.SH,
                          Description(center: center),
                          20.SH,

                        ],
                      ),
                    ),
                    // ProductTitleWithImage(product: widget.product)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: MoreServiceButton(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
