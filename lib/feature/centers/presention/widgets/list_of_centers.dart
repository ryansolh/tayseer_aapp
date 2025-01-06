import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:todo_apps/core/component/my_custom_image_viewer.dart';

import '../../../../core/services/map_service/get_distance_function.dart';
import '../../data/centers_data.dart';
import '../../data/model.dart';
import '../pages/center_details.dart';
class SlideAnimation4 extends StatefulWidget {
  @override
  State<SlideAnimation4> createState() => _SlideAnimation4State();
}

class _SlideAnimation4State extends State<SlideAnimation4> {
  List<CentersModel>? _centers;

  String distance='';

  Future calculateDistance(var centerLocation)async{


    var location=Location();
    var userLocation;

    userLocation= await location.getLocation();
    List<String> _centerLocation=centerLocation.split(',');


    distance= await Geolocator.distanceBetween(userLocation!.latitude!, userLocation!.longitude!, double.parse(_centerLocation[0]),double.parse(_centerLocation[1])).toString();


  }

      Widget build(BuildContext context) {
   _centers=Centers().items;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: AnimationLimiter(
          child: ListView.builder(
            padding: EdgeInsets.all(_w / 30),
            physics:
            BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: _centers!.length,
            itemBuilder: (BuildContext context, int index) {
              calculateDistance(_centers![index].location);


              return AnimationConfiguration.staggeredList(
                position: index,
                delay: Duration(milliseconds: 100),
                child: SlideAnimation(
                  duration: Duration(milliseconds: 2500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  verticalOffset: -250,
                  child: ScaleAnimation(
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                          return CenterDetailsScreen(center:_centers![index] );
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(vertical: 7,),
                        //  width: SizeConfig.screenWidth * 0.78,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Theme.of(context).colorScheme.background.withOpacity(0.8),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(0,0)
                              )
                            ]
                        ),
                       child:Column(
                         children: [
                           Row(

                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: [


                               SizedBox(
                                 width: _w-150,
                                 child: Column(
                                   children: [

                                     Align(
                                         alignment: Alignment.topRight,
                                         child: Text('${_centers![index].name}',textDirection: TextDirection.rtl,)
                                     ),
                                     Align(
                                         alignment: Alignment.topRight,
                                         child: Text('${_centers![index].description}',textDirection: TextDirection.rtl,overflow: TextOverflow.ellipsis,style: TextStyle(
                                           fontSize: MediaQuery.of(context).size.height*0.015
                                         ),)
                                     ),
                                     Align(
                                         alignment: Alignment.topRight,
                                         child: Text('المسافة:${distance} متر',textDirection: TextDirection.rtl,overflow: TextOverflow.ellipsis,style: TextStyle(
                                             fontSize: MediaQuery.of(context).size.height*0.015
                                         ),)
                                     ),
                                   ],
                                 )
                               ),
                               Container(
                                 height: 100,
                                 width: 100,
                                 child:   CustomImageViewer.show(
                                     context: context,
                                     url: '${_centers![index].imageUrl}'
                                 ),


                               ),
                             ],
                           ),
                         ],
                       ) ,
                      ),
                    )
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}




