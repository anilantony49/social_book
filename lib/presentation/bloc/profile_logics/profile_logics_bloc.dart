import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/domine/repository/cloud_repo/cloud_repo.dart';
import 'package:social_book/domine/repository/profile_repo/profile_repo.dart';

part 'profile_logics_event.dart';
part 'profile_logics_state.dart';

class ProfileLogicsBloc extends Bloc<ProfileLogicsEvent, ProfileLogicsState> {
  ProfileLogicsBloc() : super(ProfileLogicsInitial()) {
    on<EditUserDetailEvent>(_editUserDetailEvent);
    on<ChangeAccountTypeEvent>(_changeAccountTypeEvent);
  }
  Future<void> _editUserDetailEvent(
      EditUserDetailEvent event, Emitter<ProfileLogicsState> emit) async {
    emit(EditUserDetailsLoadingState());
    List<String> imageUrl = [];
    if (event.profilePicture.isNotEmpty) {
      imageUrl = await CloudRepo.uploadImage(event.profilePicture);
    }
    String response = await ProfileRepo.updateUserDetails(event.intialUser,
        event.updatedUser, imageUrl.isEmpty ? '' : imageUrl[0]);
    if (response == 'success') {
      emit(EditUserDetailsSuccessState());
    } else if (response == 'username-exists') {
      emit(EditUsernameAlreadyExistsState());
    } else {
      emit(EditUserDetailsErrorState());
    }
  }

  Future<void> _changeAccountTypeEvent(
      ChangeAccountTypeEvent event, Emitter<ProfileLogicsState> emit) async {
    emit(ChangeAccountTypeLoadingState());
    String response = await ProfileRepo.changeAccountType(event.accountType);
    if (response == 'success') {
      emit(ChangeAccountTypeSuccessState());
    } else {
      emit(ChangeAccountTypeErrorState());
    }
  }
}
