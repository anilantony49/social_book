import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:social_book/bottom_navigation.dart';
import 'package:social_book/presentation/screens/message/widgets/message_list_view.dart';
import 'package:social_book/presentation/screens/message/widgets/message_text_field.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final SearchController searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          // backgroundColor: theme.primaryContainer,
          body: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // kHeight(15),
                // const Text(
                //   'Chats',
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                // ),
                // kHeight(10),
                MessageTextField(searchController: searchController),
                Expanded(
                  child: MessageListView(
                    messagePageController: messagePageController,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
