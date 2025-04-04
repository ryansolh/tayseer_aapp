import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/core/network/remote/remote_dio.dart';
import 'package:todo_apps/core/utils/app_constants/blog_app_constants.dart';

import '../../../../core/component/my_custom_image_viewer.dart';
import '../../../../core/component/my_custom_subtitle.dart';
import '../../../../core/component/my_custom_title.dart';
import '../../data/data.dart';
import '../../data/model/flash_sale.dart';
import '../management/home_screen_bloc/home_screen_cubit.dart';
import '../management/home_screen_bloc/home_screen_state.dart';
import '../page/flash_sale_product_details_page.dart';
class CarouselSliderWithoutBackground extends StatefulWidget {



  @override
  State<CarouselSliderWithoutBackground> createState() => _CarouselSliderWithoutBackgroundState();
}

class _CarouselSliderWithoutBackgroundState extends State<CarouselSliderWithoutBackground> {
  late CarouselSliderController outerCarouselController=CarouselSliderController();


  List<DiscountedProductItem> _flashSaleProducts=[];



  void getAllFlashSaleProducts()async{
    try{
      var response = await DioHelper.get(
          url: baseUrl+apiUrl+flashSaleProductsUrl
      );


      if(response.statusCode==200||response.statusCode==201){
        setState(() {
          _flashSaleProducts=OfferResponseData.fromJson(response.data).sellingItems!;
        });
      }

    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return _outerBannerSlider(context);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllFlashSaleProducts();
  }

  Widget _outerBannerSlider(BuildContext context) {
    var homeData=BlocProvider.of<HomeScreenCubit>(context);
    return BlocConsumer<HomeScreenCubit,HomeScreenStete>(
        builder: (context,state){
          return Column(
            children: [
              if(_flashSaleProducts.length>0)
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
              if(_flashSaleProducts.length>0)
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
                items: _flashSaleProducts.map((data) {
                  return Builder(
                    builder: (BuildContext context) {
                      /// Custom Image Viewer widget
                      return InkWell(
                        onTap: (){
                          context.push(FlashSaleProductsDetailsScreen(product: data,));
                        },
                        child: CustomImageViewer.show(
                            context: context,
                            url: baseUrl+data.productInformation!.imageThumb!,
                            fit: BoxFit.fill,
                            radius: 20),
                      );
                    },
                  );
                }).toList(),
              ),
              if(_flashSaleProducts.length>0)
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

