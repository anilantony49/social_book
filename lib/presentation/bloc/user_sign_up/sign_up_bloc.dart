import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/domine/repository/auth_repo/auth_repo.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<UserSignUpEvent>(_userSignUpEvent);
    on<UserOtpVerificationEvent>(_userOtpVerificationEvent);
  }

  Future<void> _userSignUpEvent(
      UserSignUpEvent event, Emitter<SignUpState> emit) async {
    emit(UserSignUpLoadingState());
    SignUpResult response = await AuthRepo.userSignUp(user: event.user);
    if (response.status == 'success') {
      emit(UserSignUpSuccessState());
    } else if (response.status == 'invalid-otp') {
      emit(UserOtpErrorState());
    } else if (response.status == 'username-exists') {
      emit(UsernameExistsErrorState());
    } else if (response.status == 'email-exists') {
      emit(EmailExistsErrorState());
    } else if (response.status == 'phoneno-exists') {
      emit(PhonenoExistsErrorState());
    } else {
      emit(UserSignUpErrorState());
    }
  }

  Future<void> _userOtpVerificationEvent(
      UserOtpVerificationEvent event, Emitter<SignUpState> emit) async {
    emit(UserOtpLoadingState());
    String response = await AuthRepo.userVerifyOtp(email: event.email);
    if (response == 'success') {
      emit(UserOtpSuccessState());
    } else if (response == 'already-exists') {
      emit(UsernameExistsErrorState());
    } else {
      emit(UserOtpErrorState());
    }
  }
}
