part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class SendMessage extends ChatEvent {}

class ChangeNick extends ChatEvent {}
