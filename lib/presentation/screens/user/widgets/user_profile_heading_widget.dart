import 'package:flutter/material.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/data/services/shared_preference/shared_preference.dart';
import 'package:social_book/data/services/socket/socket_services.dart';
import 'package:social_book/presentation/screens/user_signin/user_signin_screen.dart';

class UserProfileHeadingWidget extends StatelessWidget {
  const UserProfileHeadingWidget({
    super.key,
    required this.userModel,
    required this.onProfile,
    required this.isCurrentUser,
  });
  final UserModel userModel;
  final bool onProfile;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              AppIcons.arrowleftios,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Spacer(),
          kWidth(70),
          Text(
            userModel.username!.toLowerCase(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Spacer(),
          popupmenuItems(context),
          // InkWell(

          //   child: isCurrentUser
          //       ? const SizedBox()
          //       : onProfile
          //           ? const Icon(AppIcons.settings)
          //           : const Icon(Icons.more_vert),
          // ),
        ],
      ),
    );
  }

  Widget popupmenuItems(BuildContext context) {
    return PopupMenuButton(
      onSelected: (String result) {
        switch (result) {
          case 'Send message':
            // nextScreen(
            //   context,
            //   SettingsPage(accountType: userModel.accountType!),
            // ).then((value) => Navigator.pop(context));
            break;
          case 'Report':
            break;
          case 'Cancel':
            () async {
              UserAuthStatus.saveUserStatus(false);
              SocketServices().disconnectSocket();

              await nextScreenRemoveUntil(
                context,
                const UserSigninScreen(),
              );
            };
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Send message',
          child: Text('Send message'),
        ),
        const PopupMenuItem<String>(
          value: 'Report',
          child: Text('Report'),
        ),
        const PopupMenuItem<String>(
          value: 'Cancel',
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
