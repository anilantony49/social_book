import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/screens/settings/widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.accountType});

  final String accountType;

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Settings'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(AppIcons.arrow_left),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
              shrinkWrap: true,
              children: [
                SettingsWidgets.privacyPolicyTile(context),
                kHeight(15),
                SettingsWidgets.termsConditionsTile(context),
                kHeight(15),
                SettingsWidgets.aboutUsListTile(context),
                kHeight(15),
                SettingsWidgets.logoutTile(context),
              ],
            ),
            SettingsWidgets.appVersion(context)
          ],
        ),
      ),
    );
  }
}
