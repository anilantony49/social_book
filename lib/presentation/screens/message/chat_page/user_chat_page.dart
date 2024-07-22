import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/app_colors.dart';
import 'package:social_book/data/models/chat_model/chat_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/bloc/chat/chat_bloc.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/screens/message/chat_page/widgets/chat_appbar.dart';
import 'package:social_book/presentation/screens/message/chat_page/widgets/chat_bottom_widget.dart';
import 'package:social_book/presentation/screens/message/chat_page/widgets/chat_empty_view.dart';
import 'package:social_book/presentation/screens/message/chat_page/widgets/chat_view.dart';

class UserChatPage extends StatelessWidget {
  const UserChatPage({
    super.key,
    required this.chatUser,
  });

  final UserModel chatUser;

  @override
  Widget build(BuildContext context) {
  
    return ColorfulSafeArea(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: AppColors.lLightWhite,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: ChatAppbar(user: chatUser),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, profileState) {
            if (profileState is ProfileFetchingSucessState) {
              return Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: BlocBuilder<ChatBloc, ChatState>(
                        builder: (context, state) {
                          if (state is ChatAddedState) {
                            final currentUser = profileState.userDetails;
                            bool hasMessages = _hasMessages(
                              currentUser.username!,
                              chatUser.username!,
                              state.messageList,
                            );
                            if (!hasMessages) {
                              // ============= Chat Empty View =============
                              return ChatEmptyView(chatUser: chatUser);
                            } 
                            else {
                              // ============= Chat View =============
                              return ChatView(
                                messageList: state.messageList,
                                currentUser: currentUser,
                                chatUser: chatUser,
                              );
                            }
                          }
                          return ChatEmptyView(chatUser: chatUser);
                        },
                      ),
                    ),
                  ),

                  // ============= Message Input Field =============
                  ChatBottomWidget(
                  
                    chatUser: chatUser,
                    currentUser: profileState.userDetails,
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  bool _hasMessages(
      String currentUser, String otherUser, List<ChatModel> messages) {
    return messages.any((message) =>
        (message.sender.username == currentUser &&
            message.receiver.username == otherUser) ||
        (message.receiver.username == currentUser &&
            message.sender.username == otherUser));
  }
}
