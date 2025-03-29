import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_apps/core/component/my_custom_buttons.dart';
import 'package:todo_apps/core/component/my_custom_title.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';

import '../../../../../cache/cache_helper.dart';
import '../../../../../core/component/input_widget.dart';
import '../../../../../core/component/my_custom_loading.dart';
import '../../../../../core/component/my_custom_slide_fade_transition.dart';
import '../../../../../core/component/my_custom_subtitle.dart';
import '../../../../../core/network/remote/remote_dio.dart';
import '../../../../../core/services/confirmed_app_message_sevice/snakbar_message_sevice.dart';
import '../../../../../core/utils/app_constants/blog_app_constants.dart';
import '../../../data/model/cart.dart';
import '../../../data/providers_management/card.dart';


class PaymentAndOrderReceiptMethodDialog extends StatefulWidget {
  const PaymentAndOrderReceiptMethodDialog({super.key});

  @override
  State<PaymentAndOrderReceiptMethodDialog> createState() => _PaymentAndOrderReceiptMethodDialogState();
}

class _PaymentAndOrderReceiptMethodDialogState extends State<PaymentAndOrderReceiptMethodDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 final  _addressControllrt=TextEditingController();
  final _cartNumberControllrt=TextEditingController();
  String? _shippingMethodGroupValue;//Express Delivery
  String? _pymentMethodGroupValue;

  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _shippingMethodGroupValue= 'Free Shipping';
    _pymentMethodGroupValue="COD";
  }

  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    if(cart.totalAmount<30000){
      setState(() {
        _shippingMethodGroupValue="Express Delivery";
      });
    }

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: SingleChildScrollView(
          child: Column(
            children: [
              30.SH,
              MyTitle(
                startDelay: 0,
                textOfTitle: "طريقة الدفع واستلام الطلب",
              ),
              MySubTitle(
                startDelay: 20,
                textOfSubTitle:"قم باختيار طريقة تسليم طلبك. ثم قم باختيار طريقة دفع المبلغ الخاص بمنتجات طلبك.",
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    // Align(
                    //     alignment: Alignment.topRight,
                    //     child: MyTitle(textOfTitle: "-إختر اين تريد استلام الطلب.",startDelay: 40,)
                    // ),
                    //
                    //
                    // 3.SH,
                    SlideFadeTransition(
                      curve: Curves.elasticInOut,
                      delayStart: Duration(milliseconds: 80),
                      animationDuration: const Duration(milliseconds: 1200),
                      offset: 2.5,
                      direction: Direction.horizontal,
                      child:Row(
                        textDirection: TextDirection.rtl,
                        children: [

                          Expanded(
                            child: Column(
                              children: [
                                _shippingMethodGroupValue=="Express Delivery"?Text(
                                  "سيتم توصيل طلبك اليك, ولكن يتطلب منك دفع تكلفة التوصيل اضافة الى تكلفة طلبك."
                                  ,style: TextStyle(fontSize: 12)
                                  ,textDirection: TextDirection.rtl,
                                ):Text(
                                  "سيتم توصيل طلبك اليك, ستكون تكلفة التوصيل مجانا نظرا لان تيسير يقدم عرض بانه في حال كان المستخدم تسوق باكثر من 30000 ستكون تكلفة التوصيل مجانية."
                                  ,style: TextStyle(fontSize: 12)
                                  ,textDirection: TextDirection.rtl,
                                )

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                    10.SH,
                    Align(
                        alignment: Alignment.topRight,
                        child: MyTitle(textOfTitle: "-إختر طريقة الدفع.",startDelay: 100,)
                    ),
                    SlideFadeTransition(
                      curve: Curves.elasticInOut,
                      delayStart: Duration(milliseconds: 120),
                      animationDuration: const Duration(milliseconds: 1200),
                      offset: 2.5,
                      direction: Direction.horizontal,
                      child:Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Theme(
                            data: ThemeData.light(),
                            child: Radio(
                              value: 'COD',
                              groupValue: _pymentMethodGroupValue,
                              onChanged: (dynamic value) {
                                setState(() {
                                  _pymentMethodGroupValue = value;
                                });
                                print(_pymentMethodGroupValue);
                              },
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Text("الدفع اثناء استلام طلبك",textDirection: TextDirection.rtl,)),
                                Text("يتم دفع التكلفة كاش اثناء اثناء استلام طلبك.",style: TextStyle(fontSize: 12),textDirection: TextDirection.rtl,),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),


                    3.SH,
                    SlideFadeTransition(
                      curve: Curves.elasticInOut,
                      delayStart: Duration(milliseconds: 140),
                      animationDuration: const Duration(milliseconds: 1200),
                      offset: 2.5,
                      direction: Direction.horizontal,
                      child:Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Theme(
                            data: ThemeData.light(),
                            child: Radio(
                              value: 'OnLine',
                              groupValue: _pymentMethodGroupValue,
                              onChanged: (dynamic value) {
                                setState(() {
                                  _pymentMethodGroupValue = value;
                                });
                                print(_pymentMethodGroupValue);
                              },
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Text("الدفع اون لاين",textDirection: TextDirection.rtl,)),
                                Text("تقوم بادخال بطاقة الدفع الخاصة بك, ثم يتم خصم قيمة تكلفة طلبك من بطاقة الدفع الخاصة بك.",style: TextStyle(fontSize: 12),textDirection: TextDirection.rtl,),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                    30.SH,


                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            if(_pymentMethodGroupValue!="COD")
                              makeInput(
                                  context: context,
                                  Height: MediaQuery.of(context).size.height * 0.1 * 0.75,
                                  sizeOfScreen: MediaQuery.of(context).size,
                                  prefixIcon: Icon(Icons.payment),
                                  hint: "ادخل رقم بطاقتك",
                                inputController: _cartNumberControllrt,
                                label: "ادخل رقم بطاقة الدفع الخاصة بك"
                              ),
                              MySubTitle(textOfSubTitle: "ادخل العنوان المراد توصيل المنتج اليه", startDelay: 0),
                            TextFormField(

                              cursorColor: Colors.grey,
                              textDirection: TextDirection.rtl,
                              controller: _addressControllrt,
                              keyboardType: TextInputType.multiline,
                              maxLines: 2,
                              validator: (val) => val!.isEmpty ? 'يجب عليك تعبئة هذا الحقل' : null,
                              decoration: InputDecoration(
                                hintTextDirection: TextDirection.rtl,
                                  hintText: "ادخل عنوانك هنا...",
                                  border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey),
                                  ),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54)),
                              ),
                            ),


                          ],
                        ),
                      ),
                    30.SH,
                    if(_pymentMethodGroupValue=="COD")
                    30.SH,
                    MyButtonWithBackground(
                        context: context,
                      width: double.infinity,
                      textButton: "متابعة الارسال",
                      onPressed: ()async{
                        showDialog(
                          context: context,
                          builder: (context) {
                            return MyCustomLoading();
                          },);
                        try{
                          String cartItemsJson=cartItemsToJson(cart.items.values.toList());
                          print("JSON Cart Items: ${cartItemsJson}");
                          List<dynamic> cartItems = json.decode(cartItemsJson);

                          var response=await DioHelper.post(
                              url: orderSendUrl,
                              authorization: CacheHelper.getData(key: "token"),
                              data: {
                                "paymentMethod": _pymentMethodGroupValue, //طريقة الدفع
                                "paymentStatus": 0,// دفع ام لا |   تكون 0 في حال كانت طريقة الدفع COD
                                "transactionId": "123456",// والله مانا داري
                                "paidAmount":cart.totalAmount<30000?double.parse((cart.totalAmount+5000).toStringAsFixed(2)):double.parse(cart.totalAmount.toStringAsFixed(2)),
                                "paidCurrencyName": "YER",
                                "cart": cartItems,
                                "address": {
                                  "name": CacheHelper.getData(key: "name"),
                                  "email": CacheHelper.getData(key: "email") ,
                                  "phone": "+967"+CacheHelper.getData(key: "phone"),
                                  "country": "yemen",
                                  "state": "test",
                                  "city": "sanaa",
                                  "zip": "423432",
                                  "address": _addressControllrt.text,
                                  "street": _addressControllrt.text
                                },


                                //ملاحضة اذا تريد التعديل عدل ايضا في صفحات الطلبات
                                  "shipping_method": {
                                    "name":_shippingMethodGroupValue,
                                    "cost": cart.totalAmount<30000? 5000:0,
                                    "type": cart.totalAmount<30000?"flat_cost":"min_cost"
                                  }

                              }
                          );
                          if(response.statusCode==200||response.statusCode==201){
                            showCustomSnackbar(
                                textColor: Colors.black,
                                title: "✔ تمت العملية بنجاح",
                                subTitle: "نشكرك على طلبك. تم تسجيل طلبك بنجاح وسنقوم بمراجعته. سيتم تحضير الطلب وشحنه بعد الحصول على موافقة الإدارة. سنبقيك على اطلاع دائم بحالة طلبك."
                            );
                            context.pop();
                            cart.clear();
                            context.pop();
                            context.pop();
                          }
                          else{
                            showCustomSnackbar
                              (
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                title: "فشلت العملية !!",
                                subTitle: "ناسف لحدوث مشكله في عملية ارسال الطلب يرجى المحاولة مرة اخرى. "
                            );
                            context.pop();
                          }
                        }catch(e){
                          showCustomSnackbar
                            (
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              title: "فشلت العملية !!",
                              subTitle: "ناسف لحدوث مشكله في يبدو ان اتصالك بالانترنت منقطع او ضعيف جداً. "
                          );
                          context.pop();
                        }
                      }
                    ),
                    30.SH
                  ],
                ),
              ),






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
      ),
    );
  }

}
