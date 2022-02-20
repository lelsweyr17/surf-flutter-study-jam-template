import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_practice_chat_flutter/domain/chat_bloc/chat_bloc.dart';
import 'package:surf_practice_chat_flutter/helpers/context_extension.dart';

class MessageFieldWithSendButton extends StatelessWidget {
  const MessageFieldWithSendButton({
    Key? key,
    required this.chatBloc,
  }) : super(key: key);

  final ChatBloc chatBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: chatBloc,
      builder: (context, state) {
        return SafeArea(
          child: ListTile(
            title: TextFormField(
              onChanged: _onChanged,
              initialValue: "",
              decoration: InputDecoration(
                hintText: context.localizations.message,
              ),
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
    chatBloc.messageSink.add(value);
  }

  void _onSendPressed() => chatBloc.add(SendMessage());
}
