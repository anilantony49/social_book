import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_book/data/model/user_model/user_model.dart';
import 'package:social_book/domine/repository/user_repo/user_repo.dart';

part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  SearchUserBloc() : super(SearchUserInitial()) {
    on<SearchUserEvent>(_searchUserEvent);
  }

  Future<void> _searchUserEvent(
      SearchUserEvent event, Emitter<SearchUserState> emit) async {
    emit(SearchResultLoadingState());
    List<UserModel> users =
        await UserRepo.searchUsers(event.query, event.onMessage);
    if (users.isNotEmpty) {
      emit(SearchResultSuccessState(users: users));
    } else {
      emit(SearchResultErrorState());
    }
  }
}
