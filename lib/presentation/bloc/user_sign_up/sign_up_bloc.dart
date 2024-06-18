import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_book/data/model/user_model/user_model.dart';
import 'package:social_book/domine/repository/auth_repo/auth_repo.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<UserSignUpEvent>(_userSignUpEvent);
  }

  Future<void> _userSignUpEvent(
      UserSignUpEvent event, Emitter<SignUpState> emit) async {
    final response = await AuthRepo.userSignUp(user: event.user);
    if (response.status == 'success') {
      emit(UserSignUpSuccessState());
    }
  }
}
