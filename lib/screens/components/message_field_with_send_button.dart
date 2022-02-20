import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/data/chat/chat.dart';
import 'package:surf_practice_chat_flutter/helpers/context_extension.dart';

class MessageFieldWithSendButton extends StatelessWidget {
  const MessageFieldWithSendButton({
    Key? key,
    required this.chatRepository,
  }) : super(key: key);

  final ChatRepository chatRepository;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTile(
        title: TextFormField(
          decoration: InputDecoration(
            hintText: context.localizations.message,
          ),
        ),
        trailing: const Icon(
          Icons.send,
          color: Colors.black,
        ),
      ),
    );
  }
}
