import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_book/domine/repository/forget_password_repo/forget_password_repo.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPasswordInitial()) {
    on<ForgetSentOtpEvent>(_forgetSentOtp);
    on<ForgetResetPasswordEvent>(_forgetResetPasswordEvent);
  }
    Future<void> _forgetSentOtp(
      ForgetSentOtpEvent event, Emitter<ForgetPasswordState> emit) async {
    emit(ForgetSentOtpLoadingState());
    String response = await ForgetRepo.forgetSendOtp(email: event.email);
    if (response == 'success') {
      emit(ForgetSentOtpSuccessState());
    } else if (response == 'user-not-found') {
      emit(ForgetUserNotExistState());
    } else {
      emit(ForgetSentOtpErrorState());
    }
  }
    Future<void> _forgetResetPasswordEvent(
      ForgetResetPasswordEvent event, Emitter<ForgetPasswordState> emit) async {
    emit(ForgetResetPasswordLoadingState());
    String response = await ForgetRepo.resetPassword(
        email: event.email, otp: event.otp, password: event.password);
    if (response == 'success') {
      emit(ForgetResetPasswordSuccessState());
    } else if (response == 'invalid-otp') {
      emit(ForgetResetPasswordInvalidOtpState());
    } else {
      emit(ForgetResetPasswordErrorState());
    }
  }
}
