import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/model/user_model/user_model.dart';

class UserHeadingWidget extends StatelessWidget {
  const UserHeadingWidget({
    super.key,
    required this.userModel,
    required this.onProfile,
    required this.isCurrentUser,
    required this.onTap,
  });
  final UserModel userModel;
  final bool onProfile;
  final bool isCurrentUser;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 15, 0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Colors.transparent,
              child: Icon(
                AppIcons.arrowleftios,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          kWidth(10),
          Text(
            userModel.username!.toLowerCase(),
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          InkWell(
            onTap: onTap,
            child: isCurrentUser
                ? const SizedBox()
                : onProfile
                    ? const Icon(AppIcons.settings)
                    : const Icon(AppIcons.settings),
          ),
        ],
      ),
    );
  }
}
