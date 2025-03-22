import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../../../core/component/my_custom_linear_gradient.dart';
import '../../../data/model/cart.dart';

import '../../../data/model/product.dart';
import '../../page/product_details_screen.dart';


int numOfItems = 1;

class CartCounter extends StatefulWidget {
  const CartCounter({
    Key? key,
     this.product,
  }) : super(key: key);

  final ProductDataManage? product;

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numOfItems=0;
  }


  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
   // final product = Provider.of<Product>(context);
    return Row(
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
    );
  }

  SizedBox buildOutlineButton({IconData? icon, Function? press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: ElevatedButton(
        onPressed: press as void Function()?,
        child: Icon(icon),
      ),
    );
  }
}
