import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:social_book/presentation/screens/user/user_profile_screen.dart';
import 'package:social_book/presentation/widgets/user_list_tile.dart';

class FollowSearchIdle extends StatefulWidget {
  const FollowSearchIdle({
    super.key,
    required this.followers,
    required this.isCurrentUser,
  });

  final List followers;
  final bool isCurrentUser;

  @override
  State<FollowSearchIdle> createState() => _FollowSearchIdleState();
}

class _FollowSearchIdleState extends State<FollowSearchIdle> {
  Set<String> userIds = {};

  @override
  Widget build(BuildContext context) {
    return widget.followers.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            shrinkWrap: true,
            itemCount: widget.followers.length,
            itemBuilder: (context, index) {
              final follower = widget.followers[index];
              return UserListTile(
                onTap: () {
                  context
                      .read<UserByIdBloc>()
                      .add(FetchUserByIdEvent(userId: follower['_id']));
                  nextScreen(
                    context,
                    UserProfileScreen(
                      userId: follower['_id'],
                      isCurrentUser: false,
                    ),
                  );
                },
                username: widget.followers[index]['username'].toString(),
                profileUrl:
                    widget.followers[index]['profile_picture'].toString(),
                fullname: widget.followers[index]['fullname'].toString(),
              );
            },
          )
        : Center(
            child: Text(
              widget.isCurrentUser
                  ? "No followers yet. Start connecting!"
                  : 'No followers found!!',
              style: const TextStyle(fontSize: 15),
            ),
          );
  }
}
