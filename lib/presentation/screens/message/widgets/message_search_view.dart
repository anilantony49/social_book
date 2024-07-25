import 'package:flutter/material.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/screens/message/chat_page/user_chat_page.dart';


class MessageSearchView extends StatelessWidget {
  const MessageSearchView({
    super.key,
    required this.chatUsersList,
  });

  final List<UserModel> chatUsersList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      itemCount: chatUsersList.length,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final chatUser = chatUsersList[index];
        return InkWell(
          onTap: () {
            nextScreen(
              context,
              UserChatPage(chatUser: chatUser),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12, top: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Theme.of(context).colorScheme.onSurface,
                  backgroundImage: chatUser.profilePicture == ""
                      ? Image.asset(profilePlaceholder).image
                      : NetworkImage(chatUser.profilePicture!),
                ),
                kWidth(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatUser.fullName!,
                      style: const TextStyle(fontSize: 15),
                    ),
                    kHeight(5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 250,
                      child: Text(
                        chatUser.username!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
