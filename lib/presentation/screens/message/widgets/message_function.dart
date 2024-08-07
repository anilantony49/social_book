

import 'package:social_book/data/models/chat_model/chat_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';

class MessageFunctions {
  static ChatModel getLastMessage(
      UserModel currentUser, List<ChatModel> messageList, UserModel chatUser) {
    ChatModel? lastMessage;
    List<ChatModel> receivedMessages = messageList
        .where(
          (message) =>
              message.sender.username == chatUser.username ||
              message.receiver.username == chatUser.username,
        )
        .toList();
    List<ChatModel> sendMessages = messageList
        .where(
          (message) =>
              message.sender.username == currentUser.username ||
              message.receiver.username == currentUser.username,
        )
        .toList();

    if (receivedMessages.isNotEmpty) {
      lastMessage = receivedMessages.last;
    } else if (sendMessages.isNotEmpty) {
      lastMessage = sendMessages.last;
    }
    return lastMessage!;
  }

  static sortChatUserList({
    required List<UserModel> chatUsersList,
    required UserModel currentUser,
    required List<ChatModel> messageList,
  }) {
    chatUsersList.sort((a, b) {
      ChatModel lastMessageA =
          MessageFunctions.getLastMessage(currentUser, messageList, a);
      ChatModel lastMessageB =
          MessageFunctions.getLastMessage(currentUser, messageList, b);
      return lastMessageB.sendAt.compareTo(lastMessageA.sendAt);
    });
    return chatUsersList;
  }
}
