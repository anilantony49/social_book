import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_book/data/models/notificatoin_model/notification_model.dart';
import 'package:social_book/domine/repository/notification_repo/notification_repo.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
   on<FetchAllNotificationEvent>(_fetchAllNotifications);
    on<ClearAllNotificationEvent>(_clearAllNotificationEvent);
  }
    Future<void> _fetchAllNotifications(
      FetchAllNotificationEvent event, Emitter<NotificationState> emit) async {
    emit(FetchAllNotificationLoadingState());
    List<NotificationModel> notifications =
        await NotificationRepo.getAllNotification();
    if (notifications.isNotEmpty) {
      emit(FetchAllNotificationSuccessState(notifications: notifications));
    } else {
      emit(FetchAllNotificationErrorState());
    }
  }

  Future<void> _clearAllNotificationEvent(
      ClearAllNotificationEvent event, Emitter<NotificationState> emit) async {
    bool response = await NotificationRepo.clearAllNotification();
    if (response) {
      emit(ClearAllNotificationSuccessState());
    } else {
      emit(ClearAllNotificationErrorState());
    }
  }
}
