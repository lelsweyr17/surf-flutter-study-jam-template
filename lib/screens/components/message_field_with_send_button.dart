import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/data/chat/chat.dart';
import 'package:surf_practice_chat_flutter/domain/chat_bloc/chat_bloc.dart';
import 'package:surf_practice_chat_flutter/helpers/context_extension.dart';

class MessageFieldWithSendButton extends StatefulWidget {
  const MessageFieldWithSendButton({
    Key? key,
    required this.chatBloc,
  }) : super(key: key);

  final ChatBloc chatBloc;

  @override
  State<MessageFieldWithSendButton> createState() =>
      _MessageFieldWithSendButtonState();
}

class _MessageFieldWithSendButtonState
    extends State<MessageFieldWithSendButton> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget.chatBloc,
      builder: (context, state) {
        return SafeArea(
          child: ListTile(
            leading: IconButton(
              icon: const Icon(Icons.share_location_rounded),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            title: TextFormField(
              controller: textController,
              onChanged: _onChanged,
              decoration: InputDecoration(
                hintText: context.localizations.message,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(
                    ChatRepository.maxMessageLength),
              ],
            ),
            trailing: IconButton(
              onPressed: _onSendPressed,
              icon: (state is SendingMessage)
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.send),
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }

  void _onChanged(String value) {
    print("_onChanged $value");

    widget.chatBloc.messageSink.add(value);
  }

  void _onSendPressed() {
    print("_onSendPressed");

    widget.chatBloc.add(SendMessage());
    textController.clear();
  }
}
