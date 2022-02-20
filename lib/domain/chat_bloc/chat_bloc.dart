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
      await _refreshScreen(emit);
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

  final errorStream = StreamController<String>();

  Future<void> _refreshScreen(Emitter emit) async {
    print("_refreshScreen");
    emit(ChatInitial());
  }

  Future<void> _sendMessage(Emitter emit) async {
    print("_sendMessage --- nickName: $_nickName, message: $_message");

    emit(SendingMessage());
    try {
      await _chatRepository.sendMessage(_nickName, _message);
      messageSink.add("");
      emit(ChatInitial());
    } on InvalidNameException catch (e, _) {
      errorStream.add(e.message);
      emit(ChatInitial());
    } on InvalidMessageException catch (e, _) {
      errorStream.add(e.message);
      emit(ChatInitial());
    } catch (e) {
      print(e);
    }
  }

  Future<List<ChatMessageDto>> get messages async {
    try {
      final _messages = await _chatRepository.messages;
      return _messages;
    } catch (e) {
      emit(ChatInitial());
      throw UnimplementedError(e.toString());
    }
  }

  bool isMyUser(String name) => name == _nickName;
}
