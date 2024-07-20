import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/notificatoin_model/notification_model.dart';
import 'package:social_book/presentation/bloc/notification/notification_bloc.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/screens/notification/widgets/comment_notify_card.dart';
import 'package:social_book/presentation/screens/notification/widgets/follow_notifiy_card.dart';
import 'package:social_book/presentation/screens/notification/widgets/like_notify_card.dart';
import 'package:social_book/presentation/screens/notification/widgets/notfiy_appbar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<NotificationBloc>().add(FetchAllNotificationEvent());
  }

  List<NotificationModel> filterNotification(
      List<NotificationModel> notifications) {
    return notifications
        .where((notification) => notification.updatedAt != '')
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(80), child: NotifyAppbar()),
        body: RefreshIndicator(
            onRefresh: _handleRefresh,
            child: MultiBlocBuilder(
                blocs: [
                  context.watch<NotificationBloc>(),
                  context.watch<ProfileBloc>(),
                ],
                builder: (context, state) {
                  var state1 = state[0];
                  var state2 = state[1];
                  // if(state is FetchAllNotificationLoadingState){
                  //     return const NotificationLoadingWidget();
                  // }

                  if (state1 is FetchAllNotificationSuccessState) {
                    if (state2 is ProfileFetchingSucessState) {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          final filteredNotifications =
                              filterNotification(state1.notifications);
                          final notification = filteredNotifications[index];

                          if (notification.type == 'like') {
                            return LikeNotifyCard(
                              notificationModel: notification,
                              currentUser: state2.userDetails,
                            );
                          }

                          if (notification.type == 'comment') {
                            return CommentNotifyCard(
                              notificationModel: notification,
                              currentUser: state2.userDetails,
                            );
                          }

                          if (notification.type == 'follow') {
                            return FollowNotifyCard(
                              notificationModel: notification,
                            );
                          }

                          return Container(
                            height: 50,
                            color: Colors.white,
                            child: Text(state1.notifications[index].type),
                          );
                        },
                        separatorBuilder: (context, index) => kHeight(15),
                        itemCount: state1.notifications.length,
                      );
                    }
                  }
                  return const Center(
                    child: Text('No new nofications'),
                  );
                })),
      ),
    );
  }
}
