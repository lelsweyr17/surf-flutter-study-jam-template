import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';
import 'package:surf_practice_chat_flutter/domain/chat_bloc/chat_bloc.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({
    Key? key,
    required this.chatBloc,
  }) : super(key: key);

  final ChatBloc chatBloc;

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();

    return FutureBuilder<List<ChatMessageDto>>(
      future: widget.chatBloc.messages,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          print("error ${snapshot.error}");
          return const Center(child: Text("No data"));
        }

        List messages = snapshot.requireData;
        messages.sort((a, b) => b.createdDateTime.compareTo(a.createdDateTime));

        return ListView.builder(
          reverse: true,
          controller: _scrollController,
          itemCount: messages.length,
          itemBuilder: (context, itemNumber) {
            final message = messages[itemNumber];

            return ListTile(
              title: Text(message.author.name),
              subtitle: Text(message.message),
              trailing: Text(message.createdDateTime.toString()),
            );
          },
        );
      },
    );
  }
}
