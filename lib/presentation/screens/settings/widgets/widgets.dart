import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/presentation/screens/settings/widgets/setting_listtile.dart';
import 'package:social_book/presentation/screens/settings/widgets/theme_page.dart';
import 'package:social_book/presentation/screens/user_signin/user_signin_screen.dart';

class SettingsWidgets {
  static Positioned appVersion(BuildContext context) {
    return const Positioned(
      bottom: 50,
      child: Center(
        child: Text(
          'v 1.2.0',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }

  static SettingListTile aboutUsListTile(context) {
    return SettingListTile(
      leadingIcon: AppIcons.about,
      title: 'About us',
      // trailing: const Icon(AppIcons.arrow_circle_right),
      onTap: () {
        // nextScreen(context, const AboutUsPage());
      },
    );
  }

  static SettingListTile privacyPolicyTile(context) {
    return SettingListTile(
      leadingIcon: AppIcons.text_file,
      title: 'Privacy & policy',
      // trailing: const Icon(AppIcons.arrow_circle_right),
      onTap: () {
        // nextScreen(context, const PrivacyAndPolicyPage());
      },
    );
  }

  static SettingListTile termsConditionsTile(context) {
    return SettingListTile(
      leadingIcon: AppIcons.text_file,
      title: 'Terms & Conditions',
      // trailing: const Icon(AppIcons.arrow_circle_right),
      onTap: () {
        // nextScreen(context, const TermsAndConditionsPage());
      },
    );
  }

  static SettingListTile changeThemeTile(BuildContext context) {
    return SettingListTile(
      leadingIcon: AppIcons.moon,
      title: 'Change theme',
      // trailing: const Icon(AppIcons.arrow_circle_right),
      onTap: () {
        nextScreen(context, const ThemeSwitchPage());
      },
    );
  }

  static SettingListTile logoutTile(BuildContext context) {
    return SettingListTile(
      leadingIcon: AppIcons.logout_2,
      title: 'Logout',
      // trailing: const SizedBox(),
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
