import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/chat_model/chat_model.dart';

class OtherUserMessageCard extends StatelessWidget {
  const OtherUserMessageCard({
    super.key,
    required this.message,
  });

  final ChatModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 110,
            ),
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              boxShadow: kBoxShadow,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Text(
              message.message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          kWidth(8),
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              DateFormat('h:mm:a').format(message.sendAt.toLocal()),
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
