import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:slimy_card_plus/slimy_card.dart';
import 'package:todo_apps/core/component/my_custom_buttons.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';

import '../../../../core/component/my_custom_linear_gradient.dart';
import '../../../../core/component/my_custom_shadermask.dart';
import '../../../ai_bot/presention/page/bot_screen.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  static TextAlign _textAlign=TextAlign.right;
  static const apiKey = "AIzaSyDuMtC3ovafvJy8xb0gpkBv3eSQe_oJ8yI";

  static const assistantText =
      "انت مساعدآلي خاص بنظام تيسير التطبيق الذي تطويره بواسطة المهندس  ريان صلح والمهندس عبد الرحيم سالم والمهندس احمد العزي والمهندس ايمن رمزي والمهندس حميد البيهسي ومهمتك هي الرد عن استفسارات العملاء حول الاشياء التي تساعد ذوي الاحتياحات الخاصة في المجال الصحي, وتعطي نصائح صحية تفيد ذوي الاحتياجات الخاصة او ذوي الهمم   واذا كان السؤال خارج هذة المواضيع ان مهمتك فقط الرد على استفسارات العملاء حول الاشياء التي تساعد ذوي الاحتياحات الخاصة في المجال الصحي, وتعطي نصائح صحية تفيد ذوي الاحتياجات الخاصة او ذوي الهمم ولا تستطيع توفير معلومات اخرى وايضا لا تتحدث عن من قام بتطوير التطبيق الا اذا سالوك عمن الذي قام بتطوير التطبيق او بناءه. ";

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final TextEditingController _userMessage = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final FocusNode _focusNode = FocusNode();

  var formKey = GlobalKey<FormState>();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: HelpScreen.apiKey);

  final List<Message> _messages = [];

  bool isLoading = false;

  Future<void> sendMessage() async {
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
    final messageWithInstruction = "${HelpScreen.assistantText}\n\n$userMessageText";
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









