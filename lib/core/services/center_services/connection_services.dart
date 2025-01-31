
import 'package:url_launcher/url_launcher.dart';

import '../confirmed_app_message_sevice/snakbar_message_sevice.dart';

void whatsAppCommunicationServiceWithCenter(String whatsAppNumberOfCenter)async{
  final whatsappUrl="https://wa.me/$whatsAppNumberOfCenter";
  if(await canLaunch(whatsappUrl)){
    await launch(whatsappUrl);
  }else{
    showCustomSnackbar(title:"لايمكن فتح واتساب!" , subTitle: 'تاكد من تثبيت تطبيق واتساب الرسمي على هاتفك̨ ثم حاول مرة اخرى.');
    throw "لايمكن فتح واتساب! تاكد من تثبيت تطبيق واتساب الرسمي على هاتفك̨ ثم حاول مرة اخرى.";

  }
}


Future<void> makePhoneCallServeceWithCenter(String phone) async {
  final phoneUrl = "tel:$phone";

  if (await canLaunch(phoneUrl)) {
    await launch(phoneUrl);
  } else {
    // طباعة رسالة إذا لم يتم فتح الرابط
    showCustomSnackbar(title:"عذراً !!" , subTitle: 'يبدو ان هناك مشكلة ما!!   نرجو المحاوله لاحقاً.');
    throw "لا يمكن فتح الرابط";
  }
}