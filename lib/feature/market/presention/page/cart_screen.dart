import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';

import '../../../../core/component/my_custom_buttons.dart';
import '../../data/model/cart.dart';
import '../../data/model/orders.dart';
import '../widgets/cart/cart_widget.dart';
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
          children: <Widget>[
            20.SH,
            Card(
              shadowColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
              color: Theme.of(context).colorScheme.background,
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      ':المجموع',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: MediaQuery.of(context).size.height*0.025),
                    ),
                    10.SW,
                    Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',

                   style:Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: MediaQuery.of(context).size.height*0.02),
                    ),
                    Spacer(),

                    MyButtonWithBackground(
                      width: MediaQuery.of(context).size.height*0.15,
                      //  height: 40,
                        context: context,
                      textButton: "اطلب الان",
                      onPressed: (){
                        Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(),
                          cart.totalAmount,
                        );
                        cart.clear();
                      }

                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => CartWidget(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].title,
                  cart.items.values.toList()[i].imageUrl,
                ),
              ),
            )
          ],
      ),
    );
  }
}
