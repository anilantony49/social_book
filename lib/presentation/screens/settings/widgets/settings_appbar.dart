import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_icons.dart';

class SettingsAppbar extends StatelessWidget {
  const SettingsAppbar({
    super.key,
    // required this.theme,
    required this.title,
  });

  // final ThemeData theme;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      elevation: 0,
      bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            color: Colors.black,
          )),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      titleSpacing: 2,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            AppIcons.arrow_left,
            size: 24,
          )),
    );
  }
}
