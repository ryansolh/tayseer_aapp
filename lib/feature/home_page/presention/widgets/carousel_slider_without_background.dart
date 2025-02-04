import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/component/my_custom_image_viewer.dart';
import '../../../../core/component/my_custom_subtitle.dart';
import '../../../../core/component/my_custom_title.dart';
import '../../data/data.dart';
import '../management/home_screen_bloc/home_screen_cubit.dart';
import '../management/home_screen_bloc/home_screen_state.dart';
class CarouselSliderWithoutBackground extends StatelessWidget {
  late CarouselSliderController outerCarouselController=CarouselSliderController();

  @override
  Widget build(BuildContext context) {

    return _outerBannerSlider(context);
  }
  Widget _outerBannerSlider(BuildContext context) {
    var homeData=BlocProvider.of<HomeScreenCubit>(context);
    return BlocConsumer<HomeScreenCubit,HomeScreenStete>(
        builder: (context,state){
          return Column(
            children: [
              Column(
                children: const [
                  Align(
                    alignment: Alignment.topRight,
                    child:  Padding(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        child: MyTitle(textOfTitle: "عروض واسعار قد تعجبك..", startDelay: 500)
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child:  Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      child:  MySubTitle(textOfSubTitle: "نقدم لك عروض لقطع ومستلزمات قد تحتاجها وباسعار منخفضة!!!", startDelay: 700),
                    ),
                  ),
                ],

              ),
              CarouselSlider(

                carouselController: outerCarouselController,

                /// It's options
                ///
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  aspectRatio: 16 / 8,
                  viewportFraction: .50,
                  onPageChanged: (index, reason) {

                    homeData.onChangeouterCurrentPage(index);

                  },
                ),

                /// Items
                items: AppData.outerStyleImages.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      /// Custom Image Viewer widget
                      return CustomImageViewer.show(
                          context: context,
                          url: imagePath,
                          fit: BoxFit.fill,
                          radius: 20);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 10,
              ),

            ],
          );

        },
        listener: (context,state){

        }
    );
  }
}

