import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';

class UserHeadingWidget extends StatelessWidget {
  const UserHeadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 15, 0),
      child: Row(
        children: [
         
          CircleAvatar(
            radius: 13,
            backgroundColor: Colors.grey,
            child: Icon(
              AppIcons.arrow_left_ios,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          kWidth(10),
          const Text(
            'username',
            style: TextStyle(fontVariations: fontWeightW700),
          ),
          const Spacer(),
          PopupMenuButton(itemBuilder: (BuildContext context) {
            return [PopupMenuItem(child: Text(''))];
          })
        ],
      ),
    );
  }
}
