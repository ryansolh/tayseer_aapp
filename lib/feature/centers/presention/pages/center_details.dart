import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:todo_apps/core/component/my_custom_image_viewer.dart';
import 'package:todo_apps/core/component/my_custom_shadermask.dart';
import 'package:todo_apps/core/component/my_custom_subtitle.dart';
import 'package:todo_apps/core/component/my_custom_title.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/feature/centers/presention/widgets/more_services.dart';

import '../../../../core/component/my_custom_linear_gradient.dart';

import '../../data/model.dart';

const kDefaultPadding = 20.0;
const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

class CenterDetailsScreen extends StatelessWidget {
  final CentersModel? center;

  const CenterDetailsScreen({Key? key, this.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(center!.distance);
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
      body: Container(
        color: Theme.of(context).colorScheme.background,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
          child: SingleChildScrollView(

            child: Column(
              children: <Widget>[
                Stack(
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
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(

                          children: <Widget>[
                            20.SH,
                            Align(
                              alignment: Alignment.topRight,
                              child: MyTitle(
                                  textOfTitle: "عن المركز او المؤسسة",
                                  startDelay: 0
                              ),
                            ),
                            Align(
                            alignment: Alignment.topRight,
                            child: MySubTitle(
                            startDelay: 300,
                            textOfSubTitle:  center!.description,
                                                      ),
                          ),


                            20.SH,


                            Align(
                              alignment: Alignment.topRight,
                              child: MyTitle(
                                  textOfTitle: "المسافة",
                                  startDelay:400
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: MySubTitle(
                                  textOfSubTitle: "يبعد عنك حوالي ${center!.distance} كيلو.",
                                  startDelay: 700
                              ),
                            ),


                            20.SH,
                            Align(
                              alignment: Alignment.topRight,
                              child: MyTitle(
                                  textOfTitle: "خدمات المركز او المؤسسة",
                                  startDelay:800
                              ),
                            ),

                            AnimationLimiter(
                              child: ListView.builder(
                                shrinkWrap: true,

                                padding: EdgeInsets.all(size.width / 30),
                                physics:
                                BouncingScrollPhysics(parent: NeverScrollableScrollPhysics()),
                                itemCount: center!.services.length,
                                itemBuilder: (BuildContext context, int index) {

                                  // calculateDistance(_centers![index].location);


                                  return Column(

                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: MySubTitle(
                                            textOfSubTitle: '▪ ${center!.services[index].name}.',
                                            startDelay: 700
                                        ),
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,

                                          padding: EdgeInsets.all(size.width / 30),
                                          physics:
                                          BouncingScrollPhysics(parent: NeverScrollableScrollPhysics()),
                                          itemCount: center!.services.length,
                                          itemBuilder: (BuildContext context, int indexOfSubServices){
                                            return Align(
                                              alignment: Alignment.topRight,
                                              child: MySubTitle(
                                                  textOfSubTitle: '   -  ${center!.services[index].subServices[indexOfSubServices]}.',
                                                  startDelay: 700
                                              ),
                                            );
                                          }
                                         ),


                                    ],
                                  );
                                },
                              ),
                            ),

                            ListTile(
                              trailing: MyShaderMask(toolWidget: Icon(Icons.location_on_outlined), radius: 1),
                              subtitle:MySubTitle(
                                  textOfSubTitle: "العنوان:   ${center!.address}",
                                  startDelay: 1100
                              ) ,
                            ),



                            60.SH





                          ],
                        ),
                      ),
                    ),
                    // ProductTitleWithImage(product: widget.product)
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
      floatingActionButton: MoreServiceButton(context,center: center!),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
