import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:surf_practice_chat_flutter/data/chat/chat.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(ChatRepository chatRepository)
      : _chatRepository = chatRepository,
        super(ChatInitial()) {
    on<ChatEvent>((event, emit) async {
      await _handleEvents(event, emit);
    });

    _nameController.stream.listen((nickName) {
      _nickNameStream = nickName;
      print("nickname $_nickName");
    });

    _messageController.stream.listen((message) {
      _message = message;
      print("message $_message");
    });
  }

  final ChatRepository _chatRepository;
  String _nickNameStream = "";
  String _nickName = "";
  String _message = "";

  Future<void> _handleEvents(
    ChatEvent event,
    Emitter emit,
  ) async {
    if (event is ChangeNick) {
      await _changeNick();
    } else if (event is SendMessage) {
      await _sendMessage(emit);
    } else {
      throw UnimplementedError("Unimplemented chat event");
    }
  }

  final _nameController = StreamController<String>();

  final _messageController = StreamController<String>();

  Sink<String> get messageSink => _messageController.sink;

  Sink<String> get nameSink => _nameController.sink;

  Future<void> _changeNick() async {
    print("_changeNick: $_nickNameStream");

    _nickName = _nickNameStream;
  }

  Future<void> _sendMessage(Emitter emit) async {
    print("_sendMessage --- nickName: $_nickName, message: $_message");

    emit(SendingMessage());
    try {
      _chatRepository.sendMessage(_nickName, _message);
      messageSink.add("");
      emit(ChatInitial());
    } catch (e) {
      print(e);
    }
  }

  Stream<List<ChatMessageDto>> get messages =>
      Stream.fromFuture(_chatRepository.messages);
}
