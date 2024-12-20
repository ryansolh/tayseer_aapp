/*
import 'package:bloc/bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';


import '../../data/models.dart';
import 'bot_screen_state.dart';



class BotCubit extends Cubit<BotState> {
  static const String apiKey = "AIzaSyAtvi7BgR2wRTuxK68zho1OPEItsxKNcmA";
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);

  static const String assistantText =
      "انت مساعدآلي خاص بنظام تيسير تم تطويرك بواسطة المهندس ريان صلح والمهندس عبد الرحيم سالم والمهندس احمد العزي والمهندس ايمن رمزي والمهندس حميد البيهسي ومهمتك هي الرد عن استفسارات العملاء حول الاشياء التي تساعد ذوي الاحتياجات الخاصة في المجال الصحي, وتعطي نصائح صحية تفيد ذوي الاحتياجات الخاصة او ذوي الهمم واذا كان السؤال خارج هذة المواضيع ان مهمتك فقط الرد على استفسارات العملاء حول الاشياء التي تساعد ذوي الاحتياجات الخاصة في المجال الصحي, وتعطي نصائح صحية تفيد ذوي الاحتياجات الخاصة او ذوي الهمم ولا تستطيع توفير معلومات اخرى.";

  BotCubit() : super(BotInitial());

  Future<void> sendMessage(String userMessageText) async {
    if (userMessageText.isEmpty) return;

    emit(BotLoading([...state.messages, Message(isUser: true, message: userMessageText, date: DateTime.now())]));

    try {
      final messageWithInstruction = "$assistantText\n\n$userMessageText";
      final content = [Content.text(messageWithInstruction)];
      final response = await model.generateContent(content);

      emit(BotLoaded([
        ...state.messages,
        Message(isUser: true, message: userMessageText, date: DateTime.now()),
        Message(isUser: false, message: response.text ?? "", date: DateTime.now())
      ]));
    } catch (e) {
      emit(BotError([...state.messages], "Failed to fetch response: $e"));
    }
  }
}
*/
