part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {}

class SignUpInitial extends SignUpState {}

class UserSignUpSuccessState extends SignUpState {}

class UserOtpSuccessState extends SignUpState {}

