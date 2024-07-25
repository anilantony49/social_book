import 'dart:developer';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_consumer.dart';
import 'package:social_book/bottom_navigation.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/bloc/chat/chat_bloc.dart';
import 'package:social_book/presentation/bloc/get_chat/get_chat_bloc.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/bloc/search_user/search_user_bloc.dart';
import 'package:social_book/presentation/cubit/on_search_message/on_search_cubit.dart';
import 'package:social_book/presentation/screens/message/widgets/message_appbar.dart';
import 'package:social_book/presentation/screens/message/widgets/message_empty_view.dart';
import 'package:social_book/presentation/screens/message/widgets/message_function.dart';
import 'package:social_book/presentation/screens/message/widgets/message_list_view.dart';
import 'package:social_book/presentation/screens/message/widgets/message_search_view.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final SearchController searchController = SearchController();

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<GetChatBloc>().add(FetchAllUserChatsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MessageAppbar(searchController: searchController),
              MultiBlocConsumer(
                buildWhen: null,
                blocs: [
                  context.watch<GetChatBloc>(),
                  context.watch<SearchUserBloc>(),
                  context.watch<OnSearchMessageCubit>(),
                ],
                listener: (context, state) {
                  var chatState = state[0];
                  if (chatState is UserChatsFetchingSuccessState) {
                    context.read<ChatBloc>().add(
                        AddInitialMessageEvent(messageList: chatState.chats));
                  }
                },
                builder: (context, state) {
                  var chatState = state[0];
                  var searchState = state[1];
                  var isSearchState = state[2];
                  if (isSearchState == false) {
                    if (chatState is UserChatsFetchingLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (chatState is UserChatsFetchingSuccessState) {
                      return MultiBlocBuilder(
                        blocs: [
                          context.watch<ChatBloc>(),
                          context.watch<ProfileBloc>()
                        ],
                        builder: (context, states) {
                          var state1 = states[0];
                          var state2 = states[1];
                          if (state2 is ProfileFetchingSucessState) {
                            if (state1 is ChatAddedState) {
                              UserModel currentUser = state2.userDetails;

                              log('From chat added state');
                              List<UserModel> chatUsersList =
                                  MessageFunctions.sortChatUserList(
                                chatUsersList: chatState.chatUsersList,
                                currentUser: currentUser,
                                messageList: state1.messageList,
                              );
                              return Expanded(
                                child: RefreshIndicator(
                                  onRefresh: _handleRefresh,
                                  child: MessageListView(
                                    messagePageController:
                                        messagePageController,
                                    chatUsersList: chatUsersList,
                                    messageList: state1.messageList,
                                    currentUser: currentUser,
                                  ),
                                ),
                              );
                            }
                          }
                          return Container();
                        },
                      );
                    }
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: _handleRefresh,
                        child: const MessageEmtpyViewWidget(),
                      ),
                    );
                  } else {
                    if (searchState is SearchResultLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (searchState is SearchResultSuccessState) {
                      return Expanded(
                        child: MessageSearchView(
                          chatUsersList: searchState.users,
                        ),
                      );
                    }
                  }
                  return const Expanded(
                    child: Center(
                      child: Text('No user found'),
                    ),
                  );
                },
              ),
              // kHeight(15),
              // const Text(
              //   'Chats',
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              // ),
              // kHeight(10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
