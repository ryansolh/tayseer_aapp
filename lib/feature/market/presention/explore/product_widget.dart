import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../core/component/my_custom_shadermask.dart';
import '../../../../core/component/my_custom_shimmer.dart';
import '../../data/model/cart.dart';
import '../../data/model/product.dart';



class ProductWidget extends StatelessWidget {
  // final Product product;
  //
  // const ProductWidget({Key key, this.product}) : super(key: key);
  /* SnackBar showSnackBarOfAddedItems(Product product, Cart cart){
     return SnackBar(
       content: Text(
         'Added item to cart!',
       ),
       duration: Duration(seconds: 2),
       action: SnackBarAction(
         label: 'UNDO',
         onPressed: () {
           cart.removeSingleItem(product.id);
         },
       ),
     );
   }*/

  void addProductToCart(BuildContext context, Product product, Cart cart) {
    cart.addItem(product.id, product.price, product.title, product.imageUrl);
  }
  /*void addProductToFav(BuildContext context, Product product, Fav fav) {
    fav.addItem(product.id, product.price, product.title, product.imageUrl);
    //Scaffold.of(context).hideCurrentSnackBar();
    SnackBar(
      content: Text(
        'Added item to favorite!',
      ),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: 'UNDO',
        onPressed: () {
          fav.removeSingleItem(product.id);
        },
      ),
    );
  }*/


  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final product = Provider.of<Product>(context);
    return CachedNetworkImage(
      imageUrl: product.imageUrl,
      imageBuilder: (context, imageProvider) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child:  Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).dialogBackgroundColor,

                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black.withOpacity(0.2),
                    ),
                    child: Column(
                      textDirection: TextDirection.rtl,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        Text(
                          product.price.toString() + " ر.ي",
                          style: TextStyle(
                              fontFamily: 'Tajawal',
                              fontSize: 20,
                              color: Colors.white
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  addProductToCart(context, product, cart);
                  print("Total Cart: " + cart.itemCount.toString());

                },
                child: Container(
                  // color: Theme.of(context).colorScheme.background!,
                  margin: EdgeInsets.only(top: 5,right: 0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(18),bottomLeft: Radius.circular(18)),

                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(

                                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                                  // spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(0,0)
                              )
                            ]
                        ),
                        child: MyShaderMask(
                          toolWidget: Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.white,
                          ),
                          radius: 1,
                        )
                    ),
                  ),
                ),
              ),
            ),


          ],
        );
      },
      placeholder: (context, url) => Center(child: MyShimmer(context: context),),
      errorWidget: (context, url, error) => Center(child: MyShimmer(context: context,),),);
  }
}