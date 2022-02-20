import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:surf_practice_chat_flutter/data/chat/models/message.dart';
import 'package:surf_practice_chat_flutter/data/chat/repository/firebase.dart';
import 'package:surf_practice_chat_flutter/domain/chat_bloc/chat_bloc.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({
    Key? key,
    required this.chatBloc,
  }) : super(key: key);

  final ChatBloc chatBloc;

  @override
  Widget build(BuildContext context) {
    final _firebaseClient = FirebaseFirestore.instance;
    final firebase = ChatRepositoryFirebase(_firebaseClient);

    return FutureBuilder<List<ChatMessageDto>>(
      initialData: const [],
      future: firebase.messages,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text("No data"),
          );
        }

        final messages = snapshot.requireData;

        return SingleChildScrollView(
          child: Column(
            children: [
              for (var message in messages)
                ListTile(
                  title: Text(message.author.name),
                  subtitle: Text(message.message),
                )
            ],
          ),
        );
      },
    );
  }
}
