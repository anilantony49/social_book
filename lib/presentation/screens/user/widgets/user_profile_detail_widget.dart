import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/app_colors.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_menu.dart';
import 'package:social_book/presentation/screens/profile/widgets/user_heading_widget.dart';
import 'package:social_book/presentation/screens/user/widgets/follow_button_widget.dart';
import 'package:social_book/presentation/screens/user/widgets/post_follow_count_card.dart';
import 'package:social_book/presentation/widgets/custom_outlined_button.dart';

class UserProfileDetailsWidget extends StatelessWidget {
  const UserProfileDetailsWidget({
    super.key,
    required this.userModel,
    required this.postsList,
    required this.userId,
  });
  final UserModel userModel;
  final List<PostModel> postsList;
  final String userId;

  void followUnfollowFunction(
      UserModel currentUserModel, UserModel user, bool? isUnfollowing) {
    if (user.followers!.contains(currentUserModel) || isUnfollowing!) {
      userModel.followers!.removeWhere(
        (element) => element['_id'] == currentUserModel.id,
      );
    } else {
      userModel.followers!.add(currentUserModel.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UserHeadingWidget(
          isCurrentUser: false,
          userModel: userModel,
          onProfile: false,
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return ProfileMenu(
                    leading: const [
                      AppIcons.send,
                      AppIcons.danger,
                      AppIcons.close
                    ],
                    profileImage: userModel.profilePicture!,
                    buttonLabel: const [
                      "Sent Message",
                      "Report Account",
                      "Cancel"
                    ],
                    ontap: [
                      () {},
                      () {
                        //    nextScreen(
                        //   context,
                        //   ReportPage(userId: userModel.id!),
                        // );
                      },
                      () {
                        Navigator.pop(context);
                      }
                    ],
                  );
                });
          },
        ),
        kHeight(10),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Stack(
            clipBehavior: Clip.none,
            // alignment: Alignment.center,
            children: [
              Container(
                // height: 270,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.lLightGrey4,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 35,
                        color: Colors.black.withOpacity(0.05),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 0, 30),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
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
                      // Spacer(),
                      kHeight(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 35,
                            child: FollowButton(
                              userModel: userModel,
                              onFollowUnfollow: followUnfollowFunction,
                            ),
                          ),
                          kWidth(20),
                          _messageBtn(context, userModel),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 40,
                // bottom: 40,
                right: 10,
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileFetchingSucessState) {
                      return PostFollowCountWidget(
                        postsList: postsList,
                        userModel: userModel,
                        userId: userId,
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _messageBtn(BuildContext context, UserModel chatUser) {
    return SizedBox(
      height: 35,
      child: CustomOutlinedBtn(
        onPressed: () {
          // nextScreen(
          //   context,
          //   UserChatPage(chatUser: chatUser),
          // );
        },
        btnText: 'MESSAGE',
      ),
    );
  }
}
