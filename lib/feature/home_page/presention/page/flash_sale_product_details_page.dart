import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_apps/core/component/my_custom_image_viewer.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';



import '../../../../../cache/cache_helper.dart';
import '../../../../../core/component/my_custom_buttons.dart';
import '../../../../../core/component/my_custom_linear_gradient.dart';
import '../../../../../core/component/my_custom_slide_fade_transition.dart';
import '../../../../../core/component/my_custom_subtitle.dart';
import '../../../../../core/services/confirmed_app_message_sevice/snakbar_message_sevice.dart';
import '../../../../../core/utils/app_constants/blog_app_constants.dart';
import '../../../market/providers_management/card.dart';
import '../../../user_login/presention/pages/signup_page.dart';
import '../../data/model/flash_sale.dart';

const kDefaultPadding = 20.0;
const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

class FlashSaleProductsDetailsScreen extends StatefulWidget {
  final DiscountedProductItem? product;


  const FlashSaleProductsDetailsScreen({Key? key, this.product}) : super(key: key);

  @override
  State<FlashSaleProductsDetailsScreen> createState() => _FlashSaleProductsDetailsScreenState();
}

class _FlashSaleProductsDetailsScreenState extends State<FlashSaleProductsDetailsScreen> {
  int productQuantity=0;

  @override
  Widget build(BuildContext context) {
    final cartManage = Provider.of<Cart>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    Size size = MediaQuery.of(context).size;

    if(cart.items.containsKey(widget.product!.productInformation!.idCode)){


      for(int i=0;i<cart.itemCount;i++){

        if(cart.items.keys.toList()[i]==widget.product!.productInformation!.idCode) {
          setState(() {
            productQuantity=cart.items.values.toList()[i].quantity;
          });
        }
      }
    }else{
      setState(() {
        productQuantity=0;
      });
    }


    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: "${widget.product!.productInformation!.idCode}",
                    child: Container(
                        height: size.height/2.4,
                        child: CustomImageViewer.show(
                          radius: 0,

                          context: context,
                          url:baseUrl+ widget.product!.productInformation!.imageThumb!,
                        )
                    ),
                  ),
                  Container(
                    height:size.height ,
                    child: Container(
                      margin: EdgeInsets.only(top: size.height/2.8),
                      padding: EdgeInsets.only(
                        top: kDefaultPadding,
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                      ),
                      // height: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Column(
                              textDirection: TextDirection.rtl,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MySubTitle(
                                  textOfSubTitle: widget.product!.productInformation!.label!,
                                  startDelay: 0,
                                  textSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                                ),
                                SizedBox(height: kDefaultPadding),
                                SlideFadeTransition(
                                  curve: Curves.elasticOut,
                                  delayStart: Duration(milliseconds: 0),
                                  animationDuration: const Duration(milliseconds: 500),
                                  offset: 2.5,
                                  direction: Direction.horizontal,
                                  child:Row(
                                    textDirection: TextDirection.rtl,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          RichText(
                                            text: TextSpan(
                                              style: Theme.of(context).textTheme.labelSmall,
                                              children: [
                                                TextSpan(text: "السعر\n"),
                                                TextSpan(
                                                  style: TextStyle(decoration: TextDecoration.lineThrough),
                                                  locale: Locale('ar'),
                                                  text:  ' ${widget.product!.productInformation!.priceValue.toString()} \n ',
                                                ),
                                                TextSpan(
                                                  locale: Locale('ar'),
                                                  text:  ' ${widget.product!.productInformation!.offerPriceValue.toString()} ',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                        child: RichText(
                                          text: TextSpan(
                                            style: Theme.of(context).textTheme.labelSmall,

                                            children: [
                                              TextSpan(text: "\n",),
                                              TextSpan(
                                                style: TextStyle(decoration: TextDecoration.lineThrough),
                                                text: "ريال يمني\n",
                                              ),
                                              TextSpan(
                                                text: "ريال يمني"
                                              )
                                              /* TextSpan(text:
                        "${product!.title.substring(product!.title.indexOf('/')
                            + 1, product!.title.length)}",

                        )*/
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )

                              ],
                            ),
                            10.SH,

                            //description
                            MySubTitle(
                              startDelay: 100,
                              textOfSubTitle: widget.product!.productInformation!.briefDescription!,
                            ),


                            10.SH,
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  //padding: EdgeInsets.all(6),
                                  decoration:BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      gradient:MyLinearGradient
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(Icons.remove,color: Colors.white,),
                                      onPressed: (){
                                        if(cart.quantityOfItem>0){
                                          cart.removeSingleItem(widget.product!.productInformation!.idCode.toString());
                                          cartManage.updateQuantityOfItem(widget.product!.productInformation!.idCode.toString());
                                        }
                                        else{
                                          showCustomSnackbar
                                            (
                                              textColor: Colors.black,
                                              title: "لا يتوفر لديك من هذا العنصر!",
                                              subTitle: "يجب ان يكون لديك على الاقل عنصر واحد من هذا المنتج في السلة."
                                          );
                                        }
                                      },
                                    ),
                                  ),

                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                                  child: Text(
                                    // if our item is less  then 10 then  it shows 01 02 like that
                                      "${cart.quantityOfItem}"
                                  ),
                                ),
                                Container(
                                  decoration:BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      gradient:MyLinearGradient
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(Icons.add,color: Colors.white,),
                                      onPressed: (){
                                        if(CacheHelper.getData(key: "token")!=null){
                                          cartManage.addItem(
                                              widget.product!.productInformation!.idCode.toString(),
                                              widget.product!.productInformation!.offerPriceValue!,
                                              widget.product!.productInformation!.label!,
                                              widget.product!.productInformation!.imageThumb!
                                          );
                                          print("Total Cart: " + cart.itemCount.toString());
                                          cartManage.updateQuantityOfItem(widget.product!.productInformation!.idCode!.toString());
                                        }
                                        else{
                                          context.push(SignupPage(fromWelcompage: false,));
                                          showCustomSnackbar
                                            (
                                              textColor: Colors.black,
                                              title: " لايمكنك اضافة اي منتج",
                                              subTitle: "يجب ان يكون لديك حساباً لتستطيع التسوق وشراء المنتجات"
                                          );
                                        }
                                      },
                                    ),
                                  ),

                                ),

                              ],
                            ),

                            50.SH,
                            Row(
                              children: <Widget>[

                                Flexible(
                                  child: Container(
                                      height: 50,

                                      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2),
                                      child: MyButtonWithBackground(
                                        context: context,
                                        fontSize: 15,


                                        onPressed: (){
                                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
                                        },
                                        textButton: "اذهب الى السلة",
                                        // height: h*0.6

                                      )
                                  ),
                                ),
                              ],
                            ),
                            MySubTitle(
                              startDelay: 150,
                              textOfSubTitle: widget.product!.productInformation!.fullDescription!,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // ProductTitleWithImage(product: widget.product)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
