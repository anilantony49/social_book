import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/presentation/screens/settings/widgets/setting_listtile.dart';
import 'package:social_book/presentation/screens/user_signin/user_signin_screen.dart';

class SettingsWidgets {
  static SettingListTile logoutTile(BuildContext context) {
    return SettingListTile(
      leadingIcon: AppIcons.logout_2,
      title: 'Logout',
      trailing: const SizedBox(),
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: 'Comeback Soon!',
            description: 'Are you sure, you want \nto logout',
            popBtnText: 'Cancel',
            actionBtnTxt: 'Logout',
            onTap: () async {
              // context.read<ChatBloc>().add(ClearAllMessageEvent());
              // UserAuthStatus.saveUserStatus(false);
              // SocketServices().disconnectSocket();

              await nextScreenRemoveUntil(
                context,
                const UserSigninScreen(),
              );
              // mySystemTheme(context);
            },
          ),
        );
      },
    );
  }
}
