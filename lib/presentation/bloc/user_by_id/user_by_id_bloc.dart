import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/domine/repository/user_repo/user_repo.dart';

part 'user_by_id_event.dart';
part 'user_by_id_state.dart';

class UserByIdBloc extends Bloc<UserByIdEvent, UserByIdState> {
  UserByIdBloc() : super(UserByIdInitial()) {
    on<FetchUserByIdEvent>(fetchUserByIdEvent);
  }

  Future<void> fetchUserByIdEvent(
      FetchUserByIdEvent event, Emitter<UserByIdState> emit) async {
    emit(FetchUserByIdLoadingState());
    UserDetailsModel? userDetail =
        await UserRepo.fetchUserDetailsById(event.userId);
    if (userDetail != null) {
      emit(FetchUserByIdSuccessState(
          userModel: userDetail.user, posts: userDetail.posts));
    } else {
      emit(FetchUserByIdErrorState());
    }
  }
}
