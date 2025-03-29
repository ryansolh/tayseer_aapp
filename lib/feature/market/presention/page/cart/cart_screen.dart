import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import 'package:todo_apps/cache/cache_helper.dart';
import 'package:todo_apps/core/component/my_custom_subtitle.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/feature/market/presention/page/order/pyment_and_order_receipt_method_page.dart';

import '../../../../../core/component/my_custom_buttons.dart';
import '../../../../../core/services/confirmed_app_message_sevice/snakbar_message_sevice.dart';
import '../../../../user_login/presention/pages/signup_page.dart';

import '../../../data/providers_management/card.dart';
import '../../widgets/cart/cart_widget.dart';
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
   // List<CartItem> _cartItems=.

    print(cart.items.values.toList());
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
                      ':المجموع الكلي',
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
                        context.push(PaymentAndOrderReceiptMethodDialog());
                       if(CacheHelper.getData(key: "token")!=null){
                         if(cart.items.length>0){
                         //  paymentAndOrderReceiptMethodDialog( context: context,);

                         }
                         else{
                           showCustomSnackbar
                             (
                               backgroundColor: Colors.red,
                               textColor: Colors.white,
                               title: "لا يمكن ارسال الطلب!!",
                               subTitle: "يجب ان يكون لديك على الاقل منتج واحد لتتمكن من ارسال الطلب "
                           );
                         }
                       }
                       else{
                         context.push(SignupPage(fromWelcompage: false,));
                         showCustomSnackbar(
                           textColor: Colors.black,
                           title: " لايمكنك ارسال الطلب!",
                           subTitle: "يجب ان يكون لديك حساباً لتستطيع ارسال الطلبات."
                         );
                        }
                      }
                        // Provider.of<Orders>(context, listen: false).addOrder(
                        //   cart.items.values.toList(),
                        //   cart.totalAmount,
                        // );
                        // cart.clear();


                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child:cart.items.length>0? ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => CartWidget(
                  cart.items.values.toList()[i].id.toString(),
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].name,
                  cart.items.values.toList()[i].imageUrl,
                ),
              ):Center(
                child: MySubTitle(
                  startDelay: 50,
                  textOfSubTitle: "لا توجد عناصر في السلة!",
                ),
              ),
            )

          ],
      ),
    );
  }
}
