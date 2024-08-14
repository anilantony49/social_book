import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/bloc/follow_unfollow_user/follow_unfollow_user_bloc.dart';
import 'package:social_book/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:social_book/presentation/screens/profile/connection_list/widgets/follow_button.dart';
import 'package:social_book/presentation/screens/user/user_profile_screen.dart';

class FollowingSearchIdle extends StatefulWidget {
  const FollowingSearchIdle({
    super.key,
    required this.following,
    required this.isCurrentUser,
  });

  final List following;
  final bool isCurrentUser;

  @override
  State<FollowingSearchIdle> createState() => _FollowingSearchIdleState();
}

class _FollowingSearchIdleState extends State<FollowingSearchIdle> {
  @override
  Widget build(BuildContext context) {
    return widget.following.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            shrinkWrap: true,
            itemCount: widget.following.length,
            itemBuilder: (context, index) {
              final following = widget.following[index];
              final userModel = UserModel.fromJson(following);

              return InkWell(
                onTap: () {
                  context
                      .read<UserByIdBloc>()
                      .add(FetchUserByIdEvent(userId: following['_id']));
                  nextScreen(
                      context,
                      UserProfileScreen(
                        userId: following['_id'],
                        isCurrentUser: false,
                      ));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: following['profile_picture'] == ""
                        ? Image.asset(profilePlaceholder).image
                        : NetworkImage(
                            following['profile_picture'],
                          ),
                  ),
                  title: Text(
                    following['fullname'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  minVerticalPadding: 18,
                  subtitle: Text(
                    following['username'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  trailing: SizedBox(
                    width: 94,
                    height: 30,
                    child: FollowButtonConnectionList(
                      userModel: userModel,
                      onFollowUnfollow: (user, model, isUnfollowed) {
                        if (isUnfollowed) {
                          context.read<FollowUnfollowUserBloc>().add(
                                UnfollowUserEvent(
                                  userId: model.id!,
                                  name: model.fullName!,
                                ),
                              );
                        } else {
                          context.read<FollowUnfollowUserBloc>().add(
                                FollowUserEvent(
                                  userId: model.id!,
                                  name: model.fullName!,
                                ),
                              );
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Text(
              widget.isCurrentUser
                  ? "You haven't followed anyone yet."
                  : "No following found!!",
              style: const TextStyle(fontSize: 15),
            ),
          );
  }
}
