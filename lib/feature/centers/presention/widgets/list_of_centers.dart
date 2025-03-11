

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:todo_apps/core/component/my_custom_image_viewer.dart';
import '../../../../core/component/my_custom_loading.dart';
import '../../../../core/component/my_custom_shadermask.dart';
import '../../../../core/network/remote/remote_dio.dart';
import '../../../../core/utils/app_constants/blog_app_constants.dart';
import '../../data/centers_data.dart';
import '../../data/model.dart';
import '../pages/center_details.dart';
class SlideAnimation4 extends StatefulWidget {
  @override
  State<SlideAnimation4> createState() => _SlideAnimation4State();
}

class _SlideAnimation4State extends State<SlideAnimation4> {
  late List<CenterModel>? _centers;
  late List<CenterModel>? _originalCenters;
  late List<CenterModel>? _permanentCenters;

  //String distance='';
  final TextEditingController _searchController=TextEditingController();
  bool _emptySearchText=true;

  bool successfulGettingDistance=false;
  bool successfulGettingCenters=false;

  Future calculateDistance()async{
    var location=Location();
    var userLocation;
    userLocation= await location.getLocation();

    for(int i=0;i<_centers!.length;i++) {
      setState(() {
        _centers![i].distance=Geolocator.distanceBetween(userLocation!.latitude!, userLocation!.longitude!,_centers![i].latitude,_centers![i].longitude).toInt()/1000;

      });

      // print(_centers![i].distance!);

    }


    setState(() {
      successfulGettingDistance=true;
      _originalCenters=_centers;
    });

  }

  Future gettingAllCenters()async{
    try{

      //await DioHelper.init();
      var response=await DioHelper.get(
          url: CentersDataUrl,
         // authorization: 'Bearer $token'
      );
      setState(() {

        _centers=(response.data as List)
            .map((data) => CenterModel.fromJson(data as Map<String, dynamic>))
            .toList();
        calculateDistance();
        successfulGettingCenters=true;
      });
     // print(_centers);

    }catch(e){
      print(e);
    }
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    gettingAllCenters();
  }




  Widget build(BuildContext context) {

    double _w = MediaQuery.of(context).size.width;
    double _h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: successfulGettingCenters==false?
      MyCustomLoading():
      Container(
      height: _h,
      width: _w,
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textDirection: TextDirection.rtl,
                    controller:_searchController,

                    cursorColor: Colors.grey.withOpacity(0.4),
                    autofocus: false,

                    style: TextStyle(color: Theme.of(context).textTheme.labelSmall!.color),
                    onChanged: (value) {
                      if(value.isNotEmpty){
                        setState(() {
                          _centers=_originalCenters!
                              .where((center) => center.name.contains(value))
                              .toList();
                          _emptySearchText=false;
                        });
                      }
                      else{
                        setState(() {
                          _centers=_originalCenters!;
                          _emptySearchText=true;
                        });
                      }
                    },
                    // controller: serchController,
                    decoration: InputDecoration(
                        hintTextDirection: TextDirection.rtl,
                        hintText: "ابحث عن مركز معين",
                        // filled: true,

                        fillColor: Theme.of(context).colorScheme.background,
                        hoverColor: Theme.of(context).colorScheme.background.withOpacity(0.1),
                        focusColor: Theme.of(context).colorScheme.background.withOpacity(0.1),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        suffixIcon: const MyShaderMask(
                          toolWidget: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          radius: 1.3,
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)
                            )
                        )
                    ),

                  ),
                ),


                MyShaderMask(
                    toolWidget:  PopupMenuButton<String>(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      color: Theme.of(context).colorScheme.background,
                      // color: Get.isDarkMode ? darkGreyColor : Colors.white,
                      icon: const Icon(Icons.sort,color: Colors.grey,),
                      padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                      tooltip: "More",
                      onSelected: (value)  {
                        if (value == "فرز حسب الاقرب مسافة") {
                          setState(() {
                            _centers!.sort((a, b) => a.distance.compareTo(b.distance));
                          });


                        }
                        else if (value == "فرز حسب الابعد مسافة") {
                          setState(() {
                            _centers!.sort((a, b) => b.distance.compareTo(a.distance));
                          });
                          // sortByTheFurthest();

                        }
                        else if (value == "فرز حسب الابجدية تصاعديا") {
                          setState(() {
                            _centers!.sort((a, b) => a.name.compareTo(b.name));
                          });
                          // sortByTheFurthest();

                        }
                        else if (value == "فرز حسب الابجدية تنازليا") {
                          setState(() {
                            _centers!.sort((a, b) => b.name.compareTo(a.name));
                          });
                          // sortByTheFurthest();
                        }
                        else if (value == "فرز حسب المراكز المستهدفة لفئتك") {
                          setState(() {

                          });
                          // sortByTheFurthest();
                        }
                      },
                      itemBuilder: (BuildContext context) {

                        return [

                          const PopupMenuItem(
                            value: "فرز حسب الاقرب مسافة",
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Text("فرز حسب الاقرب مسافة")
                            ),
                          ),

                          const PopupMenuItem(
                              value: "فرز حسب الابعد مسافة",
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text("فرز حسب الابعد مسافة"),
                              )
                          ),
                          const PopupMenuItem(
                            value: "فرز حسب الابجدية تصاعديا",
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text("فرز حسب الابجدية تصاعديا"),
                            ),),
                          const PopupMenuItem(
                            value: "فرز حسب الابجدية تنازليا",
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text("فرز حسب الابجدية تنازليا"),
                            ),
                          ),
                          const PopupMenuItem(
                            value: "فرز حسب المراكز المستهدفة لفئتك",
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text("فرز حسب المراكز المستهدفة لفئتك"),
                            ),
                          )
                        ];
                      },
                    ),
                    radius: 1.3
                ),
              ],
            ),
          ),


          Expanded(
            flex: 12,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: AnimationLimiter(
                child: ListView.builder(

                  padding: EdgeInsets.all(_w / 30),
                  physics:
                  const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemCount: _centers!.length,
                  itemBuilder: (BuildContext context, int index) {

                    // calculateDistance(_centers![index].location);


                    return AnimationConfiguration.staggeredList(
                      position: index,
                      delay: const Duration(milliseconds: 100),
                      child: SlideAnimation(
                        duration: const Duration(milliseconds: 2500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        verticalOffset: -250,
                        child: ScaleAnimation(
                            duration: const Duration(milliseconds: 1500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                                  return CenterDetailsScreen(center:_centers![index] );
                                }));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
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
                                          offset: const Offset(0,0)
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
                                                    child: Text('المسافة:${_centers![index].distance} كيلو',textDirection: TextDirection.rtl,overflow: TextOverflow.ellipsis,style: TextStyle(
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
                                              url: '${_centers![index].image}'
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
          ),

        ],
      ),
    ),
    );
  }
}




