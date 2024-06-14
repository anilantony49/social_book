import 'package:flutter/material.dart';
import 'package:social_book/presentation/screens/explore/widget/custom_search_field.dart';

class MessageTextField extends StatefulWidget {
  const MessageTextField({super.key, required this.searchController});
  final SearchController searchController;
  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      color: theme.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              children: [
                Expanded(
                    flex: 6,
                    child: CustomSearchField(
                      heading: 'Chats',
                      searchController: widget.searchController,
                      hintText: 'Search chat here...',
                    ))
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              'All Messages',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}
