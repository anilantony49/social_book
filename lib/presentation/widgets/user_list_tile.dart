import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/screens/user/widgets/custom_outlined_button.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    super.key,
    required this.onTap,
    required this.profileUrl,
    required this.fullname,
    required this.username,
    this.buttonText,
  });

  final void Function()? onTap;
  final String profileUrl;
  final String fullname;
  final String username;
  final String? buttonText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: profileUrl == ""
              ? Image.asset(profilePlaceholder).image
              : NetworkImage(profileUrl),
        ),
        title: Text(
          fullname,
          style: const TextStyle(
            fontSize: 15,
            fontVariations: fontWeightW600,
            height: 1.5,
          ),
          maxLines: 1,
        ),
        minVerticalPadding: 18,
        subtitle: Text(
          '@$username',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        trailing: SizedBox(
          width: 94,
          height: 30,
          child: CustomOutlinedButton(
            onPressed: () {},
            btnText: buttonText ?? 'VIEW',
          ),
        ),
      ),
    );
  }
}
