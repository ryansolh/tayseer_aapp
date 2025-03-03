import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_apps/core/component/my_custom_loading.dart';

import '../../../../core/component/my_custom_shadermask.dart';
import '../../../../core/component/my_custom_shimmer.dart';
import '../../data/model/cart.dart';
import '../../data/model/product.dart';



class ProductWidget extends StatelessWidget {

  final void Function(GlobalKey) onClick;

  ProductWidget({super.key, required this.onClick,});
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
    cart.addItem(product.id, product.price, product.name, product.imageUrl);
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
    final GlobalKey widgetKey = GlobalKey();
    final cart = Provider.of<Cart>(context, listen: false);
    final product = Provider.of<Product>(context);



      return CachedNetworkImage(
        imageUrl: product.imageUrl,
        imageBuilder: (context, imageProvider) {
          return Container(
            child: SizedBox(
              child: Stack(
                children: [
                  Container(
                    key: widgetKey,
                    child: SizedBox(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child:  Container(
                            //  key: widgetKey,
                            decoration: BoxDecoration(
                              color: Theme.of(context).dialogBackgroundColor,

                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16)
                            ),
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: Column(
                            textDirection: TextDirection.rtl,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.rtl,
                              ),
                              Text(
                                product.price.toString() + " ر.ي",
                                style: const TextStyle(
                                    color: Colors.white
                                ),
                                overflow: TextOverflow.ellipsis,
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
                        onClick(widgetKey);
                        addProductToCart(context, product, cart);
                        print("Total Cart: " + cart.itemCount.toString());

                      },
                      child: Container(
                        // color: Theme.of(context).colorScheme.background!,
                        margin: const EdgeInsets.only(top: 5,right: 0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(18),bottomLeft: Radius.circular(18)),

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
                                        offset: const Offset(0,0)
                                    )
                                  ]
                              ),
                              child: const MyShaderMask(
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
              ),
            ),
          );
        },
        placeholder: (context, url) => Center(child: MyShimmer(context: context),),
        errorWidget: (context, url, error) => Center(child: MyShimmer(context: context,),),);


  }
}