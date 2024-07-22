import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/bloc/follow_unfollow_user/follow_unfollow_user_bloc.dart';
import 'package:social_book/presentation/screens/profile/connection_list/connection_list_page.dart';

class PostFollowCountWidget extends StatelessWidget {
  const PostFollowCountWidget({
    super.key,
    required this.postsList,
    required this.userModel,
    required this.userId,
  });

  final List<PostModel> postsList;
  final UserModel userModel;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowUnfollowUserBloc, FollowUnfollowUserState>(
      builder: (context, state) {
        return SizedBox(
          height: 50,
          child: Row(
            children: [
              _userPostFollowCountCard(
                count: '${postsList.length}',
                title: 'POSTS',
                onTap: () {},
              ),
              Container(
                // height: double.infinity,
                width: 1,
                color: Colors.black,
              ),
              _userPostFollowCountCard(
                count: '${userModel.followers!.length}',
                title: 'FOLLOWERS',
                onTap: () {
                  nextScreen(
                    context,
                    ConnectionListPage(
                      selectedPage: 0,
                      followers: userModel.followers!,
                      following: userModel.following!,
                      userId: userId,
                    ),
                  );
                },
              ),
              Container(
                height: double.infinity,
                width: 1,
                color: Colors.black,
              ),
              _userPostFollowCountCard(
                count: '${userModel.following!.length}',
                title: 'FOLLOWING',
                onTap: () {
                  nextScreen(
                    context,
                    ConnectionListPage(
                      selectedPage: 1,
                      followers: userModel.followers!,
                      following: userModel.following!,
                      userId: userId,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _userPostFollowCountCard(
      {required String count, required String title, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        width: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count,
              style: const TextStyle(fontSize: 22),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
