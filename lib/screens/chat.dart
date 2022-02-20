import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:surf_practice_chat_flutter/data/chat/repository/repository.dart';
import 'package:surf_practice_chat_flutter/domain/chat_bloc/chat_bloc.dart';
import 'package:surf_practice_chat_flutter/screens/components/app_bar.dart';
import 'package:surf_practice_chat_flutter/screens/components/chat_messages.dart';
import 'package:surf_practice_chat_flutter/screens/components/message_field_with_send_button.dart';

/// Chat screen templete. This is your starting point.
class ChatScreen extends StatefulWidget {
  final ChatRepository chatRepository;

  const ChatScreen({
    Key? key,
    required this.chatRepository,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatBloc chatBloc;
  late final StreamSubscription errorStream;

  @override
  void initState() {
    super.initState();
    chatBloc = ChatBloc(widget.chatRepository);

    errorStream = chatBloc.errorStream.stream.listen((message) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    });
  }

  @override
  void dispose() {
    errorStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: chatBloc,
      builder: (context, state) => Scaffold(
        appBar: ChatAppBar(chatBloc: chatBloc),
        body: ChatMessages(chatBloc: chatBloc),
        bottomNavigationBar: MessageFieldWithSendButton(chatBloc: chatBloc),
      ),
    );
  }
}
