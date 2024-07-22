import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/presentation/bloc/notification/notification_bloc.dart';
import 'package:social_book/presentation/widgets/custom_outlined_button.dart';

class NotifyAppbar extends StatelessWidget {
  const NotifyAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(AppIcons.arrowleftios),
          ),
          const Text(
            'Notifications',
            style: TextStyle(fontSize: 22),
          ),
          const Spacer(),
          SizedBox(
            height: 35,
            child: CustomOutlinedBtn(
              onPressed: () {
                context
                    .read<NotificationBloc>()
                    .add(ClearAllNotificationEvent());
              },
              btnText: 'MARK AS READ',
            ),
          )
        ],
      ),
    );
  }
}