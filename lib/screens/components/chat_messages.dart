import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/domain/chat_bloc/chat_bloc.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({
    Key? key,
    required this.chatBloc,
  }) : super(key: key);

  final ChatBloc chatBloc;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
