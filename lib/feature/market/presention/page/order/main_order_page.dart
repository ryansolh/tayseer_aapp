import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_apps/cache/cache_helper.dart';
import 'package:todo_apps/core/component/my_custom_shadermask.dart';
import 'package:todo_apps/core/network/remote/remote_dio.dart';
import 'package:todo_apps/core/utils/app_constants/blog_app_constants.dart';
import 'package:todo_apps/feature/market/presention/page/order/received_order.dart';
import 'package:todo_apps/feature/market/presention/page/order/unreceived_order.dart';

import '../../../../../core/component/my_custom_drawer.dart';
import '../../../data/model/orders.dart';
class MainOrderPage extends StatefulWidget {
   MainOrderPage({super.key});

  @override
  State<MainOrderPage> createState() => _MainOrderPageState();
}

class _MainOrderPageState extends State<MainOrderPage> {
  List<Order> orders=[];
  int indexOfPage=0;
 bool successGettingAllOrders= false;


  void gettingAllOrders()async{
    try{
      var response= await DioHelper.get(
        url: getOrdersUrl,
        authorization: CacheHelper.getData(key: "token"),
      );

      if(response.statusCode==200||response.statusCode==201){
        print(response.data);
        setState(() {
          orders=OrderResponse.fromJson(response.data).data!;

          successGettingAllOrders=true;
        });
      }


    }
    catch(e){
      print(e);
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingAllOrders();

  }
  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      goBack:true ,
      titleOfPage: "طلباتي",
      page:DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:Theme.of(context).colorScheme.background,
            toolbarHeight: 0,
            leading: Container(),
            bottom: TabBar(
              indicatorColor: Color(0x00000000),


              onTap: (index){
                print(index);
                setState(() {
                  indexOfPage=index;
                });
              },
              tabs: [
                indexOfPage==0? MyShaderMask(
                    toolWidget:
                Tab(text: "طلبات تم استلامها",),
                    radius: 1
                ):Tab(text: "طلبات تم استلامها",),
                indexOfPage==1?MyShaderMask(
                    toolWidget: Tab(text: "طلبات لم يتم استلامها",),
                    radius: 1
                ):Tab(text: "طلبات لم يتم استلامها",)
              ],
            ),
          ),
         body: TabBarView(
             children: [
               ReceivedOrder(successGettingAllOrders: successGettingAllOrders,orders: orders,),
               UnreceivedOrder(successGettingAllOrders: successGettingAllOrders,orders: orders,),
             ]
         )
            ),
      )

    );
  }
}
