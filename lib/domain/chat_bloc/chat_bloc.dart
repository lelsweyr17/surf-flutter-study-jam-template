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

    _nameController.stream.listen((nickName) => _nickName = nickName);

    _messageController.stream.listen((message) => _message = message);
  }

  final ChatRepository _chatRepository;
  String _nickName = "";
  String _message = "";

  Future<void> _handleEvents(
    ChatEvent event,
    Emitter emit,
  ) async {
    if (event is RefreshScreen) {
      await _refreshScreen();
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

  Future<void> _refreshScreen() async {
    print("_refreshScreen");
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

  Future<List<ChatMessageDto>> get messages => _chatRepository.messages;
}
