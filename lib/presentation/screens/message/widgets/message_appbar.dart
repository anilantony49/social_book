import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/data/services/search_debouncer/debouncer.dart';
import 'package:social_book/presentation/bloc/search_user/search_user_bloc.dart';
import 'package:social_book/presentation/cubit/on_search_message/on_search_cubit.dart';
import 'package:social_book/presentation/screens/explore/widget/custom_search_field.dart';

class MessageAppbar extends StatefulWidget {
  const MessageAppbar({
    super.key,
    required this.searchController,
  });

  final SearchController searchController;

  @override
  State<MessageAppbar> createState() => _MessageAppbarState();
}

class _MessageAppbarState extends State<MessageAppbar> {
  final Debouncer debouncer =
      Debouncer(delay: const Duration(milliseconds: 300));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      color: Colors.white,
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
                    searchController: widget.searchController,
                    hintText: 'Start a new chat...',
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        debouncer.run(() {
                          context.read<SearchUserBloc>().add(
                              SearchUserEvent(query: value, onMessage: true));
                        });
                        context
                            .read<OnSearchMessageCubit>()
                            .onSearchChange(true);
                      } else {
                        context
                            .read<OnSearchMessageCubit>()
                            .onSearchChange(false);
                      }
                    },
                    heading: 'Chats',
                  ),
                ),
              ],
            ),
          ),
           const Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              'All messages',
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
