import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';
import 'package:surf_practice_chat_flutter/domain/chat_bloc/chat_bloc.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({
    Key? key,
    required this.chatBloc,
  }) : super(key: key);

  final ChatBloc chatBloc;

  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();

    return StreamBuilder<List<ChatMessageDto>>(
      initialData: const [],
      stream: chatBloc.messages,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text("No data"));
        }

        final messages = snapshot.requireData;

        return ListView.builder(
          reverse: true,
          controller: _scrollController,
          itemCount: messages.length,
          itemBuilder: (context, itemNumber) {
            final message = messages[itemNumber];

            return ListTile(
              title: Text(message.author.name),
              subtitle: Text(message.message),
              trailing: Text(message.createdDateTime.toUtc().toString()),
            );
          },
        );
      },
    );
  }
}
