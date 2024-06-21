import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/screens/profile/edit_profile/widgets/custom_text_button.dart';

class EditProfileAppbar extends StatefulWidget {
  final TextEditingController fullnameController;
  final TextEditingController usernameController;
  final TextEditingController bioController;
  const EditProfileAppbar({
    super.key,
    required this.fullnameController,
    required this.usernameController,
    required this.bioController,
  });

  @override
  State<EditProfileAppbar> createState() => _EditProfileAppbarState();
}

class _EditProfileAppbarState extends State<EditProfileAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Edit profile',
        style: TextStyle(
          fontSize: 18,
          fontVariations: fontWeightW500,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(AppIcons.arrow_left_ios),
      ),
      actions: [CustomTextButton(onTap: () async {}, buttonText: 'SAVE')],
    );
  }
}
