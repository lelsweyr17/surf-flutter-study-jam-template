import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surf_practice_chat_flutter/data/chat/chat.dart';
import 'package:surf_practice_chat_flutter/domain/chat_bloc/chat_bloc.dart';
import 'package:surf_practice_chat_flutter/helpers/context_extension.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({
    Key? key,
    required this.chatBloc,
  }) : super(key: key);

  final ChatBloc chatBloc;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextFormField(
        onChanged: _onChanged,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: context.localizations.enterYourNick,
          hintStyle: const TextStyle(color: Colors.white),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(ChatRepository.maxNameLength),
        ],
      ),
      titleSpacing: 8,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: IconButton(
            onPressed: _onRefreshPressed,
            icon: const Icon(Icons.refresh),
          ),
        ),
      ],
    );
  }

  void _onChanged(String value) {
    chatBloc.nameSink.add(value);
  }

  void _onRefreshPressed() {
    chatBloc.add(RefreshScreen());
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
