// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/chat_model/chat_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/data/services/socket/socket_services.dart';
import 'package:social_book/presentation/bloc/chat/chat_bloc.dart';
import 'package:social_book/presentation/bloc/get_chat/get_chat_bloc.dart';

class ChatBottomWidget extends StatefulWidget {
  const ChatBottomWidget({
    super.key,
    required this.currentUser,
    required this.chatUser,
  });

  final UserModel currentUser;
  final UserModel chatUser;

  @override
  State<ChatBottomWidget> createState() => _ChatBottomWidgetState();
}

class _ChatBottomWidgetState extends State<ChatBottomWidget> {
  bool show = false;
  bool sendButton = false;
  FocusNode focusNode = FocusNode();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (show) {
          setState(() {
            show = false;
          });
        } else {
          Navigator.pop(context);
        }
        return Future.value(false);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      focusNode.unfocus();
                      focusNode.canRequestFocus = false;
                      setState(() {
                        show = !show;
                      });
                    },
                    icon: const Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.grey,
                      size: 26,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          sendButton = true;
                        });
                      }
                    },
                    controller: messageController,
                    focusNode: focusNode,
                    style: const TextStyle(fontSize: 14),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type here...',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                kWidth(5),
                BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    return Expanded(
                      flex: 1,
                      child: sendButton
                          ? IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: const CircleBorder(),
                              ),
                              onPressed: () {
                                if (messageController.text.isNotEmpty) {
                                  if (state is ChatAddedState) {
                                    bool hasMessages = _hasMessages(
                                      widget.currentUser.username!,
                                      widget.chatUser.username!,
                                      state.messageList,
                                    );
                                    if (!hasMessages) {
                                      log('message chat is empty');
                                      context
                                          .read<GetChatBloc>()
                                          .add(FetchAllUserChatsEvent());
                                    }
                                  }
                               
                                  SchedulerBinding.instance
                                      .addPostFrameCallback((_) {
                                    SocketServices().sendMessage(
                                      message: messageController.text,
                                      currentUser: widget.currentUser,
                                      chatUser: widget.chatUser,
                                    );
                                    messageController.clear();
                                  });

                                  setState(() {
                                    sendButton = false;
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.send_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                            )
                          : const SizedBox(),
                    );
                  },
                )
              ],
            ),
          ),
          show ? emojiWidget() : Container(),
        ],
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

  Widget emojiWidget() {
    return EmojiPicker(
      config: const Config(
        categoryViewConfig: CategoryViewConfig(
          tabBarHeight: 40,
          tabIndicatorAnimDuration: Duration(milliseconds: 500),
          backgroundColor: Colors.white,
        ),
        bottomActionBarConfig: BottomActionBarConfig(
          showBackspaceButton: false,
          showSearchViewButton: false,
        ),
        emojiViewConfig: EmojiViewConfig(
          columns: 8,
          emojiSizeMax: 25,
          backgroundColor: Colors.white,
          noRecents: Text(
            'No Recents',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ),
      onEmojiSelected: (category, emoji) {
        setState(() {
          messageController.text = messageController.text + emoji.emoji;
          sendButton = true;
        });
      },
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
