part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

//user input
class TextGenerateNewTextMessageEvent extends ChatEvent{
  final String inputMessage;
  TextGenerateNewTextMessageEvent({required this.inputMessage});
}