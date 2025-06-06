

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:todo_apps/core/my_extention/my_extentions.dart';

import '../../../../core/component/my_custom_linear_gradient.dart';
import '../../../../core/component/my_custom_shadermask.dart';
class BotScreen extends StatefulWidget {
  const BotScreen({super.key});

  @override
  State<BotScreen> createState() => _BotScreenState();
}
class _BotScreenState extends State<BotScreen> {
  final TextEditingController _userMessage = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  var formKey = GlobalKey<FormState>();

   static TextAlign _textAlign=TextAlign.right;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  static const apiKey = "AIzaSyDuMtC3ovafvJy8xb0gpkBv3eSQe_oJ8yI";

  final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);

  final List<Message> _messages = [];
  bool isLoading = false;
  static const assistantText =
      "انت مساعدآلي خاص بنظام تيسير التطبيق الذي تطويره بواسطة المهندس  ريان صلح والمهندس عبد الرحيم سالم والمهندس احمد العزي والمهندس ايمن رمزي والمهندس حميد البيهسي ومهمتك هي الرد عن استفسارات العملاء حول الاشياء التي تساعد ذوي الاحتياحات الخاصة في المجال الصحي, وتعطي نصائح صحية تفيد ذوي الاحتياجات الخاصة او ذوي الهمم   واذا كان السؤال خارج هذة المواضيع ان مهمتك فقط الرد على استفسارات العملاء حول الاشياء التي تساعد ذوي الاحتياحات الخاصة في المجال الصحي, وتعطي نصائح صحية تفيد ذوي الاحتياجات الخاصة او ذوي الهمم ولا تستطيع توفير معلومات اخرى وايضا لا تتحدث عن من قام بتطوير التطبيق الا اذا سالوك عمن الذي قام بتطوير التطبيق او بناءه. ";

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
    final messageWithInstruction = "$assistantText\n\n$userMessageText";
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
      title:  const Text("الاستفسارات",
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
        body: Form(

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
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                child: Row(
                  children: [
                    Expanded(
                      flex: 15,
                      child: TextFormField(

                        controller: _userMessage,
                        focusNode: _focusNode,
                        textAlign: _textAlign,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(

                          filled: true,
                          fillColor: Theme.of(context).colorScheme.secondary.withAlpha(24),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "...إسال الذكاء الاصطناعي",
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
        )
    );
  }
}
class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;

  const Messages(
      {super.key, required this.isUser, required this.message, required this.date});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10).copyWith(
        left: isUser ? 100 : 10,
        right: isUser ? 10 : 100,
      ),
      decoration: BoxDecoration(
        gradient: isUser ? MyLinearGradient: LinearGradient(
            colors: [
              Color(0xFFE0E0E0),
              Color(0xFFE0E0E0),
              Color(0xFFE0E0E0),
              Color(0xFFE0E0E0),
            ]
        ),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30),
          bottomLeft: isUser ? const Radius.circular(30) : Radius.zero,
          topRight: const Radius.circular(30),
          bottomRight: isUser ? Radius.zero : const Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            //   softWrap: true,
            message,
            style: isUser?Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.white):Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.right,
            // textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 5),
          Text(
            date,
            style: isUser?Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.white):Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({
    required this.isUser,
    required this.message,
    required this.date,
  });
}