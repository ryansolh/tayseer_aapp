import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:todo_apps/core/component/my_custom_drawer.dart';
import 'package:todo_apps/core/component/my_custom_image_viewer.dart';
import 'package:todo_apps/core/component/my_custom_subtitle.dart';
import 'package:todo_apps/core/component/my_custom_title.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';
import 'package:todo_apps/core/utils/app_constants/blog_app_constants.dart';

import '../../../data/model/orders.dart';

class OrderProductsDetaliseScreen extends StatefulWidget {
  const OrderProductsDetaliseScreen({super.key, required this.order});
  @override
 final Order order;
  _OrderProductsDetaliseScreenState createState() => new _OrderProductsDetaliseScreenState();
}

class _OrderProductsDetaliseScreenState extends State<OrderProductsDetaliseScreen> {
  double _page = 10;


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double hight = MediaQuery.of(context).size.height;
    PageController pageController;
    pageController = PageController(initialPage: 10);
    pageController.addListener(
          () {
        setState(
              () {
            _page = pageController.page!;
          },
        );
      },
    );

    return MyDrawer(
      goBack:true ,
      titleOfPage: "الطلب رقم(${widget.order.id})",
      page: Container(
        padding: EdgeInsets.all(8),
        color: Theme.of(context).colorScheme.background,
        height: hight,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: MySubTitle(
                    textOfSubTitle: "رقم الفاتورة: ${widget.order.invoiceId}",
                    startDelay: 0
                ),
              ),
              const Align(
                alignment: Alignment.topRight,
                child: MyTitle(
                    textOfTitle: "تفاصيل المنتجات",
                    startDelay: 5
                ),
              ),
              Stack(
                children: [
                  SizedBox(
                    height: width,
                    width: width * .95,
                    child: LayoutBuilder(
                      builder: (context, boxConstraints) {
                        List<Widget> cards = [];

                        for (int indexOfProduct = 0; indexOfProduct < widget.order.productQty; indexOfProduct++) {
                          double currentPageValue = indexOfProduct - _page;
                          bool pageLocation = currentPageValue > 0;

                          double start = 20 +
                              max(
                                  (boxConstraints.maxWidth - width * .75) -
                                      ((boxConstraints.maxWidth - width * .75) / 2) *
                                          -currentPageValue *
                                          (pageLocation ? 9 : 1),
                                  0.0);

                          var customizableCard = Positioned.directional(
                            top: 20 + 30 * max(-currentPageValue, 0.0),
                            bottom: 20 + 30 * max(-currentPageValue, 0.0),
                            start: start,
                            textDirection: TextDirection.ltr,
                            child: Container(
                                height: width * .67,
                                width: width * .67,
                                alignment: Alignment.topRight,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.background,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(.3),
                                          blurRadius: 10)
                                    ]),
                              child: SingleChildScrollView(
                                physics: NeverScrollableScrollPhysics(),
                                child: Container(
                                  color: Color(0x00000000),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: (width * .67)/1.3,
                                        child: CustomImageViewer.show(
                                            context: context, url: baseUrl+widget.order.products[indexOfProduct].image,
                                            radius: 20,
                                          fit: BoxFit.contain
                                        ),
                                      ),
                                     5.SH,
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        textDirection: TextDirection.ltr,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("اسم المنتج: ${widget.order.products[indexOfProduct].name}",textDirection: TextDirection.rtl,),
                                          Text("كمية المنتج: ${widget.order.products[indexOfProduct].quantity}",textDirection: TextDirection.rtl,)
                                        ],
                                      ),
                                    )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                          cards.add(customizableCard);
                        }
                        return Stack(
                            children: cards
                        );
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: widget.order.productQty,
                      controller: pageController,
                      itemBuilder: (context, index) {
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}






