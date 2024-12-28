import 'package:ai_integration/features/chat/models/chat_model.dart';
import 'package:ai_integration/features/chat/repos/chat_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSucessState(messages: [])) {
    on<TextGenerateNewTextMessageEvent>(textGenerateNewTextMessageEvent);
  }
  List<ChatMessageModel> messages = [];
  bool generating = false;
  Future<void> textGenerateNewTextMessageEvent(TextGenerateNewTextMessageEvent event, Emitter<ChatState> emit) async {
    messages.add(ChatMessageModel(role: "user", parts: [
      ChatPartModel(text: event.inputMessage)
    ]));
    emit(ChatSucessState(messages: messages));
    generating = true;
    String generatedText = await Chatrepo.chatTextGenerationRepo(messages);
    if(generatedText.length>0){
      messages.add(ChatMessageModel(role: 'model', parts: [ChatPartModel(text: generatedText)]));
      emit(ChatSucessState(messages: messages));
    }
    generating = false;
  }
}
