import 'package:flutter/material.dart';

import 'package:surf_practice_chat_flutter/data/chat/repository/repository.dart';
import 'package:surf_practice_chat_flutter/screens/components/app_bar.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(chatRepository: widget.chatRepository),
      bottomNavigationBar: MessageFieldWithSendButton(
        chatRepository: widget.chatRepository,
      ),
    );
  }
}
