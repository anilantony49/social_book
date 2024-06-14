import 'package:flutter/material.dart';
import 'package:social_book/presentation/screens/message/widgets/message_user_card.dart';

class MessageListView extends StatelessWidget {
  const MessageListView({super.key, required this.messagePageController});

  final ScrollController messagePageController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: messagePageController,
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      itemCount: 10,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return const MessageUserCard();
      },
    );
  }
}
