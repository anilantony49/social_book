import 'package:flutter/material.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/presentation/bloc/search_user/search_user_bloc.dart';
import 'package:social_book/presentation/widgets/user_list_tile.dart';

class UserSearchResultView extends StatelessWidget {
  const UserSearchResultView({
    super.key,
    required this.state2,
  });

  final SearchResultSuccessState state2;

  @override
  Widget build(BuildContext context) {
    // var theme = Theme.of(context);
    return ListView.builder(
      itemCount: state2.users.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: UserListTile(
            onTap: () {
              // nextScreen(
              //   context,
              //   UserProfile(
              //     userId: state2.users[index].id!,
              //     isCurrentUser: false,
              //   ),
              // );
            },
            profileUrl: state2.users[index].profilePicture!,
            fullname: state2.users[index].fullName!,
            username: state2.users[index].username!,
          ),
        );
      },
    );
  }
}
