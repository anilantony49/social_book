import 'package:flutter/material.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/screens/settings/settings.dart';

class UserHeadingWidget extends StatelessWidget {
  const UserHeadingWidget({
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
      onSelected: (String result) async {
        switch (result) {
          case 'Settings':
            nextScreen(
              context,
              SettingsPage(accountType: userModel.accountType!),
            );
          //   break;
          // case 'About Us':
          //   break;
          // case 'Logout':
            // UserAuthStatus.saveUserStatus(false);
            // SocketServices().disconnectSocket();

            // await nextScreenRemoveUntil(
            //   context,
            //   const UserSigninScreen(),
            // );

            // break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Settings',
          child: Text('Settings'),
        ),
        // const PopupMenuItem<String>(
        //   value: 'About Us',
        //   child: Text('About Us'),
        // ),
        // const PopupMenuItem<String>(
        //   value: 'Logout',
        //   child: Text('Logout'),
        // ),
      ],
    );
  }
}
