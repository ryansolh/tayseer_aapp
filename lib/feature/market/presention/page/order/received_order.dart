import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';

import '../../../../../core/component/my_custom_loading.dart';
import '../../../data/model/orders.dart';
import 'order_details_screen.dart';
class ReceivedOrder extends StatelessWidget {
 final bool successGettingAllOrders;
 final List<Order> orders;
   ReceivedOrder({super.key,required this.orders, required this.successGettingAllOrders});


  @override
  Widget build(BuildContext context) {
    double _w=MediaQuery.of(context).size.width;
    return Container(
      color: Theme.of(context).colorScheme.background,

      child: successGettingAllOrders==true?
      orders.isNotEmpty?
      AnimationLimiter(
        child: ListView.builder(
          padding: EdgeInsets.all(_w / 30),
          physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemCount: orders.where((orders)=>orders.orderStatus=="delivered").length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              delay: const Duration(milliseconds: 100),
              child: SlideAnimation(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                horizontalOffset: -500,
                verticalOffset: -500,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: EdgeInsets.only(bottom: _w / 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(

                        textDirection: TextDirection.rtl,
                        children: [
                          Expanded(
                              child: Text("أسم المنتج",textDirection: TextDirection.rtl,)
                          ),
                          60.SW,
                          Text("العدد",textDirection: TextDirection.rtl,)
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:orders[index].products.length ,
                        itemBuilder: (context, indexOfProducts) {
                          return  InkWell(
                            onTap: (){
                              context.push(OrderProductsDetaliseScreen(order: orders[index],));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(

                                textDirection: TextDirection.rtl,
                                children: [
                                  Expanded(
                                      child: Text(orders[index].products[indexOfProducts].name,textDirection: TextDirection.rtl,)
                                  ),
                                  60.SW,
                                  Text(orders[index].products[indexOfProducts].quantity.toString(),textDirection: TextDirection.rtl,),
                                  10.SW
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        color: Theme.of(context).colorScheme.secondary,
                        height: 1,
                        width: double.infinity,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textDirection: TextDirection.rtl,
                        children: [
                          Column(
                            children: [
                              Text("رقم الفاتورة: ${orders[index].invoiceId}"),
                              Text("عدد انواع المنتجات: ${orders[index].productQty}"),
                              Row(
                                children: [

                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 3),
                                    decoration: BoxDecoration(
                                        color: orders[index].payment.status==0?const Color(
                                            0xFFA60F0F):Colors.indigo,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: orders[index].payment.status==0?const Text("لم يتم السداد",style: TextStyle(color: Colors.white),)
                                        :const Text("تم السداد",style: TextStyle(color: Colors.white),),
                                  ),
                                  const Text(" :حالة الطلب"),
                                ],
                              )

                            ],
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text("تكلفة الطلب: ${(orders[index].subTotal-orders[index].shippingMethod.cost)} ر.ي"),
                                orders[index].shippingMethod.cost==0?Text("تكلفة التوصيل: مجاناً        ",
                                  textDirection: TextDirection.rtl,):Text("تكلفة التوصيل: ${orders[index].shippingMethod.cost} ر.ي",
                                  textDirection: TextDirection.rtl,),
                                Text("التكلفة الكلية: ${orders[index].amount} ر.ي"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      )
          : Center(child: Text("!!ليس هناك طلبات قد تم استلامها"),)
            :MyCustomLoading(),
    );
  }
}
