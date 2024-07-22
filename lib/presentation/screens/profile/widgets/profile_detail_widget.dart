// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_colors.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/screens/profile/edit_profile/edit_profile_sreen.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_post_follow_count.dart';
import 'package:social_book/presentation/screens/profile/widgets/user_heading_widget.dart';
import 'package:social_book/presentation/widgets/custom_button_profile.dart';

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({
    super.key,
    required this.userModel,
    required this.postsList,
    this.onProfile = false,
    required this.isCurrentUser,
  });

  final UserModel userModel;
  final List<PostModel> postsList;
  final bool onProfile;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserHeadingWidget(
          isCurrentUser: isCurrentUser,
          userModel: userModel,
          onProfile: onProfile,
        ),

        // kHeight(10),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Stack(
            clipBehavior: Clip.none,
            // alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lLightGrey,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 35,
                      color: Colors.black.withOpacity(0.05),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 0, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: userModel.profilePicture == ""
                            ? Image.asset(profilePlaceholder).image
                            : NetworkImage(
                                userModel.profilePicture!,
                              ),
                      ),
                      kHeight(10),
                      Text(
                        userModel.fullName!,
                        style: const TextStyle(fontSize: 17),
                      ),
                      kHeight(10),
                      userModel.bio != '' ? Text(userModel.bio!) : Container(),
                      kHeight(10),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: CustomButtonProfile(
                          buttonText: 'Edit profile',
                          onPressed: () {
                            nextScreen(
                                context, EditProfileScreen(user: userModel));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 10,
                child: ProfilePostFollowCountWidget(
                  postsList: postsList,
                  userModel: userModel,
                  isCurrentUser: true,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
