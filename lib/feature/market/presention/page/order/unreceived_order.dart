import 'package:flutter/material.dart';

import '../../../data/model/orders.dart';
class UnreceivedOrder extends StatelessWidget {
  final bool successGettingAllOrders;
  final List<Order> orders;
  const UnreceivedOrder({super.key, required this.successGettingAllOrders,required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,

      child: Center(
        child:orders.length==0?Text("لا يوجد"):Text("يوجد"),
      ),
    );
  }
}
