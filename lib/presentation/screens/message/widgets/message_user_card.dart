import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/chat_model/chat_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/cubit/online_users/online_users_cubit.dart';
import 'package:social_book/presentation/screens/message/chat_page/user_chat_screen.dart';

class MessageUserCard extends StatefulWidget {
  const MessageUserCard({
    super.key,
    required this.chatUser,
    this.lastMessage,
  });

  final UserModel chatUser;
  final ChatModel? lastMessage;

  @override
  State<MessageUserCard> createState() => _MessageUserCardState();
}

class _MessageUserCardState extends State<MessageUserCard> {
  bool isOwnMessage = false;
  bool isReplyMessage = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileFetchingSucessState) {
        String lastMessgeTime = '';

        if (widget.lastMessage != null) {
          isOwnMessage = isOwnMessageFn(widget.lastMessage!, state.userDetails);

          isReplyMessage =
              isReplyMessageFn(widget.lastMessage!, state.userDetails);
          lastMessgeTime = isToday(widget.lastMessage!.sendAt)
              ? formatTime(widget.lastMessage!.sendAt.toLocal())
              : isYesterday(widget.lastMessage!.sendAt)
                  ? 'Yesterday'
                  : DateFormat('dd-MM-yyyy').format(widget.lastMessage!.sendAt);
        }

        return InkWell(
          onTap: () {
            nextScreen(
              context,
              UserChatPage(chatUser: widget.chatUser),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12, top: 12),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: widget.chatUser.profilePicture == ""
                          ? Image.asset(profilePlaceholder).image
                          : NetworkImage(widget.chatUser.profilePicture!),
                      radius: 28,
                      backgroundColor: Colors.white,
                    ),
                    BlocBuilder<OnlineUsersCubit, List<String>>(
                      builder: (context, state) {
                        return state.contains(widget.chatUser.username)
                            ? const Positioned(
                                bottom: 4,
                                right: 2,
                                child: CircleAvatar(
                                  radius: 6,
                                  backgroundColor: Colors.green,
                                ))
                            : const SizedBox();
                      },
                    )
                  ],
                ),
                kWidth(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatUser.fullName!,
                      style: const TextStyle(fontSize: 15),
                    ),
                    kHeight(5),
                    if (isOwnMessage)
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 250,
                        child: Text(
                          widget.lastMessage!.message,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    if (isReplyMessage)
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 250,
                        child: Text(
                          widget.lastMessage!.message,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                if (isOwnMessage)
                  Text(
                    lastMessgeTime,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                if (isReplyMessage)
                  Text(
                    lastMessgeTime,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
              ],
            ),
          ),
        );
      }
      return Container();
    });
  }

  bool isOwnMessageFn(ChatModel message, UserModel currentUser) {
    return message.sender.username == currentUser.username &&
        message.receiver.username == widget.chatUser.username;
  }

  bool isReplyMessageFn(ChatModel message, UserModel currentUser) {
    return message.receiver.username == currentUser.username &&
        message.sender.username == widget.chatUser.username;
  }
}
