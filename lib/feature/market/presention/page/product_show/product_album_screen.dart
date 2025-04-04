import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todo_apps/core/component/my_custom_drawer.dart';
import 'package:todo_apps/core/component/my_custom_shadermask.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/feature/market/data/model/product.dart';

import '../../../../../core/component/my_custom_image_viewer.dart';
import '../../../../../core/utils/app_constants/blog_app_constants.dart';
import '../../../../../core/utils/theme_data/theme_mode.dart';


class ProductAlbumScreen extends StatefulWidget {
  final List<ProductImageGallery> productImageGallery;
  ProductAlbumScreen({ required this.productImageGallery});

  @override
  State<ProductAlbumScreen> createState() => _ProductAlbumScreenState();
}

class _ProductAlbumScreenState extends State<ProductAlbumScreen> {




void imageShowDilog(BuildContext context,int index){
 int indexOfImage = index;
  showDialog(
      barrierColor: Color(0x00000000),
      context: context,
      builder: (BuildContext context){
        return Theme(
            data: themeData,
            child: Dialog(
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height>MediaQuery.of(context).size.width?MediaQuery.of(context).size.width:MediaQuery.of(context).size.height/2,
                child: Stack(
                  children: [
                    CustomImageViewer.show(
                        context: context,
                        url: baseUrl+widget.productImageGallery[indexOfImage!].image!,
                        fit:  BoxFit.contain
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              onPressed: (){
                                if(indexOfImage!<widget.productImageGallery.length-1){

                                    indexOfImage++;
                                  context.pop();
                                  imageShowDilog(context,indexOfImage);
                                }
                              },
                              icon: MyShaderMask(
                                radius: 1,
                                toolWidget: Icon(Icons.arrow_forward_ios_outlined),
                              )
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              onPressed: (){
                                if(indexOfImage!>0){

                                  indexOfImage--;
                                  context.pop();
                                  imageShowDilog(context,indexOfImage);
                                }
                              },
                              icon: MyShaderMask(
                                radius: 1,
                                toolWidget: Icon(Icons.arrow_back_ios),
                              )
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
        );
      });
}

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 3;

    return MyDrawer(
        titleOfPage: "صور اخرى للمنتج",
        page: Container(
          color: Theme.of(context).colorScheme.background,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: AnimationLimiter(
            child: GridView.count(
              physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              padding: EdgeInsets.all(_w / 60),
              crossAxisCount: columnCount,
              children: List.generate(
                widget.productImageGallery.length,
                    (int index) {
                  return InkWell(
                    onTap: (){
                      imageShowDilog(context,index);
                    },
                    child: AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: Duration(milliseconds: 500),
                      columnCount: columnCount,
                      child: ScaleAnimation(
                        duration: Duration(milliseconds: 900),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeInAnimation(
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: _w / 30, left: _w / 60, right: _w / 60),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 40,
                                  spreadRadius: 10,
                                ),
                              ],

                            ),
                            child: CustomImageViewer.show(
                                context: context,
                                url:baseUrl+widget.productImageGallery[index].image!
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        )
    );
  }
}




