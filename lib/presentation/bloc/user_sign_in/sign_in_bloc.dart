import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/domine/repository/auth_repo/auth_repo.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<UserSignInEvent>(_userSignInEvent);
  }

  Future<void> _userSignInEvent(
      UserSignInEvent event, Emitter<SignInState> emit) async {
    emit(UserSignInLoadingState());
    SignInResult response = await AuthRepo.userSignIn(
        username: event.username, password: event.password);
    if (response.status == 'success') {
      final userModel = UserModel.fromJson(response.responseBody);
      emit(UserSignInSuccessState(userModel: userModel));
    } else if (response.status == 'invalid-username') {
      emit(InvalidUsernameErrorState());
    } else if (response.status == 'invalid-password') {
      emit(InvalidPasswordErrorState());
    } else {
      emit(UserSignInErrorState());
    }
  }
}
