import 'dart:math';

import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/data/chat/chat.dart';
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
          print(snapshot.error);
          return const _LoadingInProgress();
        }

        List<ChatMessageDto> messages = snapshot.requireData;
        messages.sort((a, b) => b.createdDateTime.compareTo(a.createdDateTime));

        return ListView.separated(
          reverse: true,
          controller: _scrollController,
          itemCount: messages.length,
          itemBuilder: (context, itemNumber) {
            final message = messages[itemNumber];
            final isMyUser = widget.chatBloc.isMyUser(message.author.name);

            return _MessageItem(
              isMyUser: isMyUser,
              message: message,
            );
          },
          separatorBuilder: (_, __) => _Separator(),
        );
      },
    );
  }
}

class _LoadingInProgress extends StatelessWidget {
  const _LoadingInProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _MessageItem extends StatelessWidget {
  const _MessageItem({
    Key? key,
    required this.message,
    required this.isMyUser,
  }) : super(key: key);

  final ChatMessageDto message;
  final bool isMyUser;

  @override
  Widget build(BuildContext context) {
    final textAlign = isMyUser ? TextAlign.right : TextAlign.left;

    return Card(
      elevation: 0,
      child: ListTile(
        leading: isMyUser
            ? null
            : _Avatar(firstLetterOfName: message.author.name[0]),
        title: Text(
          message.author.name,
          textAlign: textAlign,
        ),
        subtitle: _Subtitle(
          isMyUser: isMyUser,
          message: message,
          textAlign: textAlign,
        ),
        trailing: isMyUser
            ? _Avatar(firstLetterOfName: message.author.name[0])
            : null,
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({
    Key? key,
    required this.isMyUser,
    required this.message,
    required this.textAlign,
  }) : super(key: key);

  final bool isMyUser;
  final ChatMessageDto message;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMyUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          message.message,
          textAlign: textAlign,
        ),
        Text(
          message.createdDateTime.toString(),
          textAlign: textAlign,
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    Key? key,
    required this.firstLetterOfName,
  }) : super(key: key);

  final String firstLetterOfName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.accents[Random().nextInt(16)],
      ),
      child: Center(
        child: Text(
          firstLetterOfName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).primaryColor,
      indent: 16,
      endIndent: 16,
    );
  }
}
