import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_book/data/model/post_model/post_model.dart';
import 'package:social_book/data/model/user_model/user_model.dart';
import 'package:social_book/domine/repository/profile_repo/profile_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileInitialFetchEvent>(_userDetailInitialFetchEvent);
  }

  Future<void> _userDetailInitialFetchEvent(
      ProfileInitialFetchEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileFetchingLoadingState());
    ProfileDetailsModel? userDetails = await ProfileRepo.fetchUserDetails();
    if (userDetails != null) {
      emit(ProfileFetchingSucessState(
        userDetails: userDetails.user,
        posts: userDetails.posts,
      ));
    } else {
      emit(ProfileFetchingErrorState());
    }
  }
}
