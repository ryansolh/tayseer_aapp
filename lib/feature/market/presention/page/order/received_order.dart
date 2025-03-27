import 'package:flutter/material.dart';

import '../../../data/model/orders.dart';
class ReceivedOrder extends StatelessWidget {
 final bool successGettingAllOrders;
 final List<Order> orders;
   ReceivedOrder({super.key,required this.orders, required this.successGettingAllOrders});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,

      child: Center(
        child:orders!.length==0?Text("لا يوجد"):Text("يوجد"),
      ),
    );
  }
}
