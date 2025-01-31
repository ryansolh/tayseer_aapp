import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';

import '../../../../core/component/my_custom_image_viewer.dart';
import '../../../../core/component/my_custom_title.dart';
import '../../data/data.dart';
import '../../data/model/models.dart';
import '../management/home_screen_bloc/home_screen_cubit.dart';
import '../management/home_screen_bloc/home_screen_state.dart';
import '../page/events_page.dart';

class InnerIndicatorCarouselSlider extends StatefulWidget {

  InnerIndicatorCarouselSlider({super.key});

  @override
  State<InnerIndicatorCarouselSlider> createState() => _InnerIndicatorCarouselSliderState();
}

class _InnerIndicatorCarouselSliderState extends State<InnerIndicatorCarouselSlider> {
  late CarouselSliderController innerCarouselController;
  int indexOfEventData=0;
  List<EventsModel>? _events;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _events=eventsAndSuggestions.map((data) => EventsModel.fromJson(data)).toList();
  }
  @override
  Widget build(BuildContext context) {
    innerCarouselController = CarouselSliderController();
    var homeScreenDate = BlocProvider.of<HomeScreenCubit>(context);
    Size size;
    double height, width;

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return BlocConsumer<HomeScreenCubit, HomeScreenStete>(
        builder: (context, state) {
          return SizedBox(
            height: height * .35,
            width: width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    //////////////////////////////////
                    //////////////////////////////////
                    //////////////////////////////////
                    //////////////////////////////////
                    child: CachedNetworkImage(
                      imageUrl: state is onChangeinnerCurrentPageState
                         ?_events![homeScreenDate.innerCurrentPage].imageUrl
                          : _events![homeScreenDate.innerCurrentPage].imageUrl,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          key: state is onChangeinnerCurrentPageState
                              ? ValueKey<int>(homeScreenDate.innerCurrentPage)
                              : ValueKey<int>(homeScreenDate.innerCurrentPage),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 15,
                              sigmaY: 15,
                            ),
                            child: Container(
                              color:Color(0x00000000),
                            ),
                          ),
                        );
                      },
                      placeholder: (context, url) => Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.08),
                      ),
                      errorWidget: (context, url, error) {
                        return Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Theme.of(context)
                              .colorScheme
                              .secondary

                        );
                      },
                    )),
                //////////////////////////////////
                //////////////////////////////////
                //////////////////////////////////
                //////////////////////////////////
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration:  BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.background.withOpacity(0.50),
                        Theme.of(context).colorScheme.background.withOpacity(0.70),
                        Color(0x00000000)
                      ]
                    ),
                  ),
                ),

                FadeIn(
                    duration: const Duration(milliseconds: 800),
                    child: MyInnerBannerSlider(context, height, width))
              ],
            ),
          );
        },
        listener: (context, state) {});
  }

  // ignore: non_constant_identifier_names
  Widget MyInnerBannerSlider(
      BuildContext context, double height, double width) {
    var homeScreenDate = BlocProvider.of<HomeScreenCubit>(context);
    return BlocConsumer<HomeScreenCubit, HomeScreenStete>(
        builder: (context, state) {
          return Column(
            children: [
              /// Slider Style
             const Align(
               alignment: Alignment.topRight,
               child:  Padding(
                   padding: EdgeInsets.symmetric(vertical: 9, horizontal: 15),
                   child: MyTitle(textOfTitle: "الاقتراحات والفعاليات...", startDelay: 500)
               ),
             ),

              SizedBox(
                height: height * .25,
                width: width,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    /// Carouse lSlider
                    Positioned.fill(
                      child: CarouselSlider(
                        carouselController: innerCarouselController,

                        /// It's options
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          viewportFraction: 0.8,
                          onPageChanged: (index, reason) {
                            /* setState(() {*/
                            setState(() {
                              indexOfEventData=index;
                            });
                            homeScreenDate.onChangeinnerCurrentPage(index);
                            /*   });*/
                          },
                        ),

                        /// Items
                        items: _events!.map((imagePath) {
                          return Builder(
                            builder: (BuildContext context) {
                              /// Custom Image Viewer widget

                              return InkWell(
                                onTap: (){
                                  context.push(EventDetailsScreen(event: _events![indexOfEventData],));
                                },
                                child: CustomImageViewer.show(
                                  context: context,
                                  url: imagePath.imageUrl,
                                  fit: BoxFit.fill,
                                ),
                              );
                              ///////////////////////////
                              ///////////////////////////
                              ///////////////////////////
                              ///////////////////////////
                            },
                          );
                        }).toList(),
                      ),
                    ),

                    /// Indicators

                  ],
                ),
              ),
            ],
          );
        },
        listener: (context, state) {});
  }
}

