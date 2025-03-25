import 'package:flutter/material.dart';
import 'package:todo_apps/core/component/my_custom_title.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';

import '../../component/my_custom_subtitle.dart';

Future<void> paymentAndOrderReceiptMethodDialog({required BuildContext context,}) async {
  String? shippingMethodGroupValue= "Free Shipping";

     showDialog(context: context, builder: (context) {
       return Container(
         color: Theme.of(context).colorScheme.background,
         child: SingleChildScrollView(
           child: Column(
             children: [
               const Center(
                 child: MyTitle(
                   startDelay: 0,
                   textOfTitle: "طريقة الدفع واستلام الطلب",
                 ),
               ),
               const Center(
                 child: MySubTitle(
                   startDelay: 0,
                   textOfSubTitle:"قم باختيار طريقة تسليم طلبك. ثم قم باختيار طريقة دفع المبلغ الخاص بمنتجات طلبك.",
                 ),
               ),
               20.SH,
               const Text("-إختر اين تريد استلام المنتج."),
               // const ListTile(
               //   title: Text("التسليم عند البائع"),
               //   trailing: Radio(
               //     value: "Free Shipping",
               //     groupValue:"",
               //     onChanged: ,
               //   ),
               // )
               // const ListTile(
               //   title: Text("توصيل طلبك او شحنه اليك"),
               //   trailing: Radio(
               //     value: "Express Delivery",
               //
               //   ),
               // )
             ],
           ),
         ),
       );


     },
     );
}