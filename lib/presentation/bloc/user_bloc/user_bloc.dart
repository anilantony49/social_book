import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/domine/repository/user_repo/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<FetchAllUserEvent>(_fetchAllUsersEvent);
  }

  Future<void> _fetchAllUsersEvent(
      FetchAllUserEvent event, Emitter<UserState> emit) async {
    emit(UserDetailFetchingLoadingState());
    List<UserModel> users = await UserRepo.fetchUserDetails();
    if (users.isNotEmpty) {
      emit(UserDetailFetchingSuccessState(users: users));
    } else {
      emit(UserDetailFetchingErrorState());
    }
  }
}
