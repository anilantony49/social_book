import 'package:flutter/material.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/screens/profile/connection_list/connection_list_page.dart';

class ProfilePostFollowCountWidget extends StatelessWidget {
  const ProfilePostFollowCountWidget(
      {super.key,
      required this.postsList,
      required this.userModel,
      this.isCurrentUser = false});

  final List<PostModel> postsList;
  final UserModel userModel;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          _userPostFollowCountCard(
            count: postsList.length.toString(),
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
                  isCurrentUser: isCurrentUser,
                  userId: userModel.id!,
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
                  isCurrentUser: isCurrentUser,
                  userId: userModel.id!,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
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
