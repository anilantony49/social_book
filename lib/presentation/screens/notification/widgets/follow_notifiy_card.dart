import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_colors.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/notificatoin_model/notification_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:social_book/presentation/screens/user/user_profile_screen.dart';
import 'package:social_book/presentation/screens/user/widgets/follow_button_widget.dart';

class FollowNotifyCard extends StatelessWidget {
  const FollowNotifyCard({
    super.key,
    required this.notificationModel,
  });

  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
   

    void followUnfollowFunction(
        UserModel currentUserModel, UserModel user, bool? isUnfollowing) {
      if (user.followers!.contains(currentUserModel) || isUnfollowing!) {
        notificationModel.user.followers!.removeWhere(
          (element) => element['_id'] == currentUserModel.id,
        );
      } else {
        notificationModel.user.followers!.add(currentUserModel.toJson());
      }
    }

    return InkWell(
      // onTap: () {
      //   nextScreen(
      //       context,
      //       UserProfileScreen(
      //         userId: notificationModel.user.id!,
      //         isCurrentUser: false,
      //       ));
      //   context
      //       .read<UserByIdBloc>()
      //       .add(FetchUserByIdEvent(userId: notificationModel.user.id!));
      // },
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 14),
        decoration: BoxDecoration(
          color: AppColors.lLightGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    debugPrint('Go to profile');
                    nextScreen(
                        context,
                        UserProfileScreen(
                          userId: notificationModel.user.id!,
                          isCurrentUser: false,
                        ));
                    context.read<UserByIdBloc>().add(
                        FetchUserByIdEvent(userId: notificationModel.user.id!));
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    backgroundImage: notificationModel.user.profilePicture == ""
                        ? Image.asset(profilePlaceholder).image
                        : NetworkImage(notificationModel.user.profilePicture!),
                  ),
                ),
                kWidth(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kHeight(20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 160,
                      child: Text(
                        '${notificationModel.user.fullName} followed you.',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    kHeight(10),
                    SizedBox(
                        height: 35,
                        width: 100,
                        child: FollowButton(
                          userModel: notificationModel.user,
                          onFollowUnfollow: followUnfollowFunction,
                        ))
                  ],
                ),
                const Spacer(),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                timeAgo(DateTime.parse(notificationModel.updatedAt)),
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
