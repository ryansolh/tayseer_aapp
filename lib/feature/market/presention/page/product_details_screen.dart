import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_apps/core/component/my_custom_image_viewer.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';



import '../../../../core/component/my_custom_buttons.dart';
import '../../../../core/component/my_custom_linear_gradient.dart';
import '../../../../core/component/my_custom_subtitle.dart';
import '../../../../core/services/market_services/add_or_remove_product_to_cart.dart';
import '../../../../core/utils/app_constants/blog_app_constants.dart';
import '../../data/data_sources/products.dart';
import '../../data/model/cart.dart';
import '../../data/model/product.dart';
const kDefaultPadding = 20.0;
const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

class ProductDetailsScreen extends StatefulWidget {
  final ProductDataManage? product;


  const ProductDetailsScreen({Key? key, this.product}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
   int productQuantity=0;

  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<Cart>(context);
    Size size = MediaQuery.of(context).size;

    if(cart.items.containsKey(widget.product!.id)){


      for(int i=0;i<cart.itemCount;i++){

        if(cart.items.keys.toList()[i]==widget.product!.id) {
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
                    tag: "${widget.product!.id}",
                    child: Container(
                      // height: size.height * 0.3,
                      child: CustomImageViewer.show(

                          context: context,
                          url:ImageBaseUrl+ widget.product!.thumbImage,

                      )
                    ),
                  ),
                  Container(
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
                    child: Column(
                      children: <Widget>[
                        Column(
                          textDirection: TextDirection.rtl,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product!.name,
                              style:Theme.of(context).textTheme.labelSmall ,
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(height: kDefaultPadding),
                            Row(
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

                                            locale: Locale('ar'),
                                            text:  ' ${widget.product!.price.toString()}  ',

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
                                        TextSpan(text: "ريال يمني",),
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
                          ],
                        ),
                        10.SH,

                        //description
                      MySubTitle(
                        startDelay: 0,
                        textOfSubTitle: widget.product!.shortDescription!,
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
                                  if(productQuantity>1){
                                    cart.removeSingleItem(widget.product!.id.toString());
                                  }
                                  else{
                                    cart.clear();
                                  }
                                },
                              ),
                            ),

                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                            child: Text(
                              // if our item is less  then 10 then  it shows 01 02 like that
                              productQuantity.toString()
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
                                  addProductToCart(context, widget.product!, cart);
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
                    )
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
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
