import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/data/chat/chat.dart';
import 'package:surf_practice_chat_flutter/helpers/context_extension.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({
    Key? key,
    required this.chatRepository,
  }) : super(key: key);

  final ChatRepository chatRepository;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextFormField(
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: context.localizations.enterYourNick,
          hintStyle: const TextStyle(color: Colors.white),
        ),
      ),
      titleSpacing: 8,
      actions: [
        IconButton(
          onPressed: onRefreshPressed,
          padding: const EdgeInsets.only(right: 16),
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }

  void onRefreshPressed() {

  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
