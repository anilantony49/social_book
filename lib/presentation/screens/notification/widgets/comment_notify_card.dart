import 'package:flutter/material.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/notificatoin_model/notification_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/screens/notification/widgets/post_detail_notify.dart';


class CommentNotifyCard extends StatelessWidget {
  const CommentNotifyCard(
      {super.key, required this.notificationModel, required this.currentUser});

  final NotificationModel notificationModel;
  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      onTap: () {
        nextScreen(
          context,
          PostDetailNotify(
            postId: notificationModel.postId,
            currentUser: currentUser,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(3),
                    image: DecorationImage(
                      image: NetworkImage(notificationModel.postMedia),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                kWidth(15),
                Column(
                  children: [
                    kHeight(20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 160,
                      child: Text(
                        '${notificationModel.user.fullName} commented on your post.',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                timeAgo(DateTime.parse(notificationModel.updatedAt)),
                style: TextStyle(
                    fontSize: 11, color: theme.colorScheme.onSecondary),
              ),
            )
          ],
        ),
      ),
    );
  }
}
