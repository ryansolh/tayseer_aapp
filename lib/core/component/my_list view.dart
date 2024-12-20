/*
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shimmer/shimmer.dart';
class ItemsList extends StatelessWidget {
  ItemsList({Key? key}) ;

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return  Container (
      height:height,
      width:width,
      color: Theme.of(context).colorScheme.background.withOpacity(0.99),

      child:AnimationLimiter(
        child: Container(

          height: height,
          width: width,
          child: Stack(
            children: [
              ListView.builder(

                padding: EdgeInsets.all(width / 30),
                physics:
                const BouncingScrollPhysics(parent: NeverScrollableScrollPhysics()),
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    delay: const Duration(milliseconds: 100),
                    child: SlideAnimation(
                      duration: const Duration(milliseconds: 2500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: FadeInAnimation(
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: const Duration(milliseconds: 2500),
                        child: Container(
                          margin: EdgeInsets.only(bottom: width / 20),
                          height:width / 4,
                          decoration: BoxDecoration(
                            color:Theme.of(context).colorScheme.surface,
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color:Theme.of(context).colorScheme.secondary.withOpacity(0.08),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Shimmer.fromColors(
                            highlightColor: Theme.of(context).colorScheme.surface,
                            baseColor: Colors.grey.shade300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: width / 4.1,
                                  width: width / 1.5,
                                  child: Column(

                                    children: [
                                      Text('▓▓▓▓▓▓▓▓▓                               ',
                                        style: TextStyle(fontSize:width*0.04,),
                                        textDirection: TextDirection.rtl,),
                                      Text('▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓'
                                          '▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓'
                                        ,textDirection: TextDirection.rtl,
                                        style: TextStyle(fontSize: width*0.035),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration:  BoxDecoration(
                                    color: Theme.of(context).colorScheme.surface,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft:  Radius.circular(0),
                                        bottomRight:  Radius.circular(20),
                                        topRight:  Radius.circular(20)),


                                  ),

                                  height: width / 4.1,
                                  width:width/ 4.1,
                                )

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                top: 5,
                right: 5,
                child: PopupMenuButton(
                    icon:ShaderMask(
                        blendMode: BlendMode.srcATop,
                        shaderCallback: (Rect bounds)
                        {
                          return const RadialGradient(
                            center: Alignment.topRight,
                            radius: 1.0,
                            colors: <Color>[
                              Color(0xFF9D6CAE), // أزرق داكن
                              Color(0xFF967EB9), // أزرق
                              Color(0xFF81A7D6), // أزرق فاتح
                              Color(0xFF75B6E3), // أزرق أفتح
                            ],
                            tileMode: TileMode.mirror,
                          ).createShader(bounds);

                        },
                        child:  Icon(
                            Icons.sort,
                            color: const Color(0xFF967EB9),
                            size: width*0.10)


                    ),

                    itemBuilder: (context){
                      List<PopupMenuEntry<Object>>list=[];
                      list.add(
                        const PopupMenuItem(
                          value: 'حسب الاقرب مسافه',
                          child: Text('حسب الاقرب مسافه'),
                        ),
                      );
                      list.add(
                        const PopupMenuItem(
                          value: 'حسب الابعد مسافه',
                          child: Text('حسب الابعد مسافه'),
                        ),
                      );
                      list.add(
                        const PopupMenuItem(
                          value: 'حسب الابجدية تصاعدي',
                          child: Text('حسب الابجدية تصاعدي'),
                        ),
                      );
                      list.add(
                        const PopupMenuItem(
                          value: 'حسب الابجدية تنازلي',
                          child: Text('حسب الابجدية تنازلي'),
                        ),
                      );
                      return list;
                    }),),

            ],
          ),
        ),
      ),
    );
  }
}
*/
