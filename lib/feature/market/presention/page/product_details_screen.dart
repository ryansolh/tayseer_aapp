import 'package:flutter/material.dart';
import 'package:todo_apps/core/component/my_custom_image_viewer.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';



import '../../../../core/component/my_custom_buttons.dart';
import '../../../../core/component/my_custom_linear_gradient.dart';
import '../../../../core/component/my_custom_subtitle.dart';
import '../../data/model/product.dart';
import '../widgets/details/cart_counter.dart';
const kDefaultPadding = 20.0;
const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

class ProductDetailsScreen extends StatelessWidget {
  final Product? product;

  const ProductDetailsScreen({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    tag: "${product!.id}",
                    child: Container(
                      // height: size.height * 0.3,
                      child: CustomImageViewer.show(
                          context: context,
                          url: product!.imageUrl
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
                              product!.title,
                              style:Theme.of(context).textTheme.labelSmall ,
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
                                            text:  ' ${product!.price.toString()}  ',

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
                        textOfSubTitle: product!.description!,
                      ),


                        10.SH,
                      Row(
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

                                },
                              ),
                            ),

                          ),
                          /*  buildOutlineButton(

          icon: Icons.remove,
          press: () {
            if(numOfItems>0){
              setState(() {
                numOfItems--;
              });
               removeProductToCart(context, widget.product!, cart);
            }




          },
        ),*/
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                            child: Text(
                              // if our item is less  then 10 then  it shows 01 02 like that
                              numOfItems.toString(),

                            ),
                          ),
                          Container(
                            // padding: EdgeInsets.all(6),
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient:MyLinearGradient
                            ),
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.add,color: Colors.white,),
                                onPressed: (){

                                },
                              ),
                            ),

                          ),

                        ],
                      ),

                        10.SH,
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
