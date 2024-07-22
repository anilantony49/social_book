import 'package:flutter/material.dart';
import 'package:social_book/data/models/user_model/user_model.dart';

class ChatEmptyView extends StatelessWidget {
  const ChatEmptyView({
    super.key,
    required this.chatUser,
  });

  final UserModel chatUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "start new chat!",
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
