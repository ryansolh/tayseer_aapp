import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:slimy_card_plus/slimy_card.dart';
import 'package:todo_apps/core/component/my_custom_buttons.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';

import '../../../../core/component/my_custom_linear_gradient.dart';
import '../../../../core/component/my_custom_shadermask.dart';
import '../../../ai_bot/presention/page/bot_screen.dart';
import '../../data/model.dart';

class HelpScreen extends StatefulWidget {

  HelpScreen({required this.centers,this.disabilityCategory});

   var centers;
  final String? disabilityCategory ;

  static TextAlign _textAlign=TextAlign.right;
  static const apiKey = "AIzaSyDhaRD8d2Rg_MyefnKrhFISyktIEk31Llc";

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final TextEditingController _userMessage = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final FocusNode _focusNode = FocusNode();

  var formKey = GlobalKey<FormState>();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: HelpScreen.apiKey);

  final List<Message> _messages = [];

  bool isLoading = false;
  String _disabilityCategory="";

  Future<void> sendMessage() async {

    //ساعطيك فئة الاعاقة الخاصة بالمستخدم   اذا كان يعاني من اعاقة معينه ستجيبه بالاجابة واذا كان مجرد ناشط او مؤثر اجبه بالاتي من معلومات حسابك لايتبين لي انك معاق وانما انت مجرد ناشط او مؤثر في التطبيق. واذا افترض افتراض انه معاق اجبه, واذا كان لا توجد معلومات عن نوع الاعاقة فاجبه كالاتي: انت لم تقم بانشاء حساب ولذالك انا لا اعلم ماهي فئة الاعاقة التي تنتمي اليها. واذا افترض افتراضا بانه ينتمي الى اعاقة معينه فاجبه

    final assistantText =
        "انت مساعد ذكي ودليل لمعلومات المراكز الخاصز بذوي الاحتياجات الخاصة التي تنعرض في واجهات المراكز في تطبيق تيسير سازودك معلومات المراكز على شكل موديل وهي كالاتي: ${widget.centers.toString()}  مهمتك هي الاجابة على استفسارات المستخدم حول مايخص هذه المراكز من اسم مركز او وصفه او الارقام الخاصة بالتواصل او موقع المراكز التي بالنص ولي الموقع الاحداثي  ستعتبر الService الاساسية للمركز هي الفئات التي يستهدفها المركز واما الSubService هي الخدمات التي يتم تقديمها للفئة مثلا ماهي المراكز المتوفره او قم بعمل مقارنه او ماهي الافصل للمستخدم على حسب اعاقته اذا اعطاك مانوع اعاقته      ";

    final userMessageText = _userMessage.text;


    _userMessage.clear();
    // عرض الرسالة المرسلة فقط للمستخدم
    setState(() {
      _messages.add(Message(
          isUser: true, message: userMessageText, date: DateTime.now()));
      _scrollToBottom();
      isLoading = true;
    });
    _scrollToBottom();
    // دمج النص الثابت مع الرسالة لكن إرساله فقط إلى الـ API
    final messageWithInstruction = "${assistantText}\n\n$_disabilityCategory\n\n$userMessageText";
    final content = [Content.text(messageWithInstruction)];
    var response = await model.generateContent(content,);

    setState(() {
      _messages.add(Message(
          isUser: false, message: response.text ?? "", date: DateTime.now()));
      isLoading = false;

    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.disabilityCategory=="1"){
      setState(() {
        _disabilityCategory=="نوع الاعاقة: ليس معاق وانما مجرد ناشط";
      });
    }
    if(widget.disabilityCategory=="0"){
      setState(() {
        _disabilityCategory=="نوع الاعاقة: لا توجد معلومات عن نوع الاعاقة";
      });
    }
    else{
      setState(() {
        _disabilityCategory=="نوع الاعاقة: ${widget.disabilityCategory}";
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  const Text("استفسارات حول المراكز",
            style: TextStyle(color: Colors.white, fontFamily: 'Tajawal', fontWeight: FontWeight.bold,),),
          leading: Container(),
          actions: [IconButton(onPressed: (){context.pop();}, icon: Icon(Icons.chevron_right_sharp,size: 40,color: Colors.white,))],
          flexibleSpace:
          Container(
            decoration:  BoxDecoration(
              gradient:MyLinearGradient,
            ),
          ),

        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Form(

                  key: formKey,
                  autovalidateMode: autoValidateMode,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          // reverse: true,
                          controller: _scrollController,
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            final message = _messages[index];
                            return Messages(
                              isUser: message.isUser,
                              message: message.message,
                              date: DateFormat('HH:mm').format(message.date),
                            );
                          },
                        ),
                      ),
                      if (isLoading)
                        const LinearProgressIndicator( color: Colors.blue,
                          isShaderMask: true,
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 15,
                              child: TextFormField(

                                controller: _userMessage,
                                focusNode: _focusNode,
                                textAlign: HelpScreen._textAlign,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(

                                  filled: true,
                                  fillColor: Theme.of(context).colorScheme.secondary.withAlpha(24),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "...إسال عن اي شيء حول المراكز",
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                ),
                                validator: (value) {
                                  //_scrollToBottom();
                                  if(value!.isEmpty ){
                                    return 'يجب تعبئة الحقل';
                                  }

                                },

                              ),
                            ),
                            const Spacer(),
                            MyShaderMask(
                                toolWidget: IconButton(
                                  padding: const EdgeInsets.all(15),
                                  iconSize: 30,
                                  splashRadius: 25,
                                  //color: MyTheme.primaryColor,
                                  icon: const Icon(Icons.send, color: Colors.black),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      sendMessage();
                                      _focusNode.requestFocus(); // الحفاظ على التركيز بعد الإرسال
                                      _focusNode.unfocus();
                                    } else {
                                      autoValidateMode = AutovalidateMode.always;
                                      setState(() {});
                                    }

                                  },
                                ),
                                radius: 1.5
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8,left: 8,bottom: 8),
                child: MyButtonNoBackground(
                    context,
                  Height: 50,
                  textButton: "الاسئلة الشائعة",
                  onPressed: (){
                      showModalBottomSheet(
                        backgroundColor:   Color(0x13000000),
                        context: context, builder:(context) {
                        return Container(
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                          ),
                        );
                      },);
                  }
                ),
              )
            ],
          ),
        )
    );
  }






}









