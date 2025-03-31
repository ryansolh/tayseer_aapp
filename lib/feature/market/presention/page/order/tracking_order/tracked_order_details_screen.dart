import 'package:flutter/material.dart';
import 'package:todo_apps/core/component/my_custom_drawer.dart';
import 'package:todo_apps/core/component/my_custom_subtitle.dart';
import 'package:todo_apps/core/component/my_custom_title.dart';
//import 'package:nb_utils/nb_utils.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';  //https://pub.dev/packages/nb_utils

class TrackingOrderPage extends StatefulWidget {
  const TrackingOrderPage({super.key, required this.orderState,});
 final String orderState;

  @override
  _TrackingOrderPageState createState() => _TrackingOrderPageState();
}

class _TrackingOrderPageState extends State<TrackingOrderPage> {



  int currStep=0;
  //controls.onStepCancel,

  /*
  processed_and_ready_to_ship
  dropped_off,
  shipped,
  out_for_delivery,
  delivered,
  pending,
  canceled
  */
  @override
  Widget build(BuildContext context) {
    setState(() {
     currStep = widget.orderState=="pending"? 0:widget.orderState=="processed_and_ready_to_ship"?1:widget.orderState=="delivered"?3:2;
    });
    List<Step> steps = [
      Step(
        state:StepState.complete,
        title: Text("الطلب معلق",textDirection: TextDirection.rtl,),
        subtitle: Text("نحن نراجع طلبك حالياً، وسيتم تحديث حالته قريباً.",textDirection: TextDirection.rtl,),
        isActive: currStep == 0,
        content: Text("تم استلام طلبك بنجاح وهو قيد المراجعة حالياً من قبل فريق المتجر. سنقوم بتحديث حالتك بمجرد تأكيد الطلب والبدء في معالجته.",textDirection: TextDirection.rtl, ),
      ),
      Step(
        title: Text("يتم تجهيز الطلب",),
        subtitle: Text("طلبك قيد التجهيز وسيكون جاهزًا للشحن قريبًا.",),
        content: Text("نحن نعمل على تجهيز طلبك بعناية لضمان جودته قبل الشحن. يتم الآن إعداده وتغليفه من قبل فريقنا، وسيتم تسليمه قريبًا لشركة التوصيل سواء عن طريق شاحنة، دراجة نارية، أو وسيلة توصيل أخرى. يمكنك متابعة حالتك باستمرار عبر التطبيق.",),
        isActive: currStep == 1,
        state: currStep>=1?StepState.complete:StepState.indexed
      ),
      Step(
        title: Text("الطلب في الطريق", ),
        subtitle: Text("طلبك في الطريق إليك، وسيصل قريبًا!",),
        content: Text("تم تسليم طلبك إلى مندوب التوصيل، وهو الآن في طريقه إليك. يمكنك توقع وصوله خلال فترة محددة. الرجاء التأكد من توفر شخص لاستلام الطلب عند الوصول.",),
        isActive: currStep == 2,
        state: currStep>=2?StepState.complete:StepState.indexed

      ),
      Step(
        title: Text("تم التوصيل",),
        subtitle: Text("تم توصيل طلبك بنجاح!",),
        content: Text("! لقد وصل طلبك وتم تسليمه إلى العنوان المحدد. نأمل أن تكون راضيًا عن تجربتك معنا. إذا كنت بحاجة إلى أي دعم أو لديك ملاحظات، لا تتردد في التواصل مع خدمة العملاء. شكراً لاختيارك متجرنا!",),
        isActive: currStep == 3,
        state: currStep==3?StepState.complete:StepState.indexed
      ),
    ];

    return Scaffold(
      body: MyDrawer(
        goBack: true,
        titleOfPage: "تتبع حالة الطلب",
        page: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child:widget.orderState!="canceled"? Stepper(

                steps: steps,
                physics: BouncingScrollPhysics(),
                type: StepperType.vertical,
                currentStep: this.currStep,
                controlsBuilder: (BuildContext context,ControlsDetails controls) {
                  return Container();
                },
                onStepContinue: () {
                  setState(() {
                    if (currStep < steps.length - 1) {
                      currStep = currStep + 1;
                    } else {
                      //currStep = 0;
                      // finish(context);
                    }
                  });
                },
                onStepCancel: () {
                  //   finish(context);
                  setState(() {
                    if (currStep > 0) {
                      currStep = currStep - 1;
                    } else {
                      currStep = 0;
                    }
                  });
                },
                onStepTapped: (step) {
                  setState(() {
                    currStep = step;
                  });
                },
              ):
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: MyTitle(
                            textOfTitle: "الطلب ملغى",
                            startDelay: 0
                        ),
                      ),
                      MySubTitle(
                          textOfSubTitle: "تم إلغاء طلبك إما بناءً على طلبك أو بسبب عدم القدرة على إتمامه، مثل عدم توفر المنتج أو تعذر التوصيل. إذا تم خصم أي مبلغ، فسيتم استرداده وفقًا لسياسة الاسترجاع الخاصة بنا. لمزيد من التفاصيل، يمكنك التواصل مع خدمة العملاء.",
                          startDelay: 100
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}

