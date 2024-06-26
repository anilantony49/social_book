part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {}

class SignUpInitial extends SignUpState {}

class UserSignUpSuccessState extends SignUpState {}

class UserOtpSuccessState extends SignUpState {}

class UserOtpErrorState extends SignUpState {}

class UsernameExistsErrorState extends SignUpState {}

class EmailExistsErrorState extends SignUpState {}

class PhonenoExistsErrorState extends SignUpState {}

class UserSignUpErrorState extends SignUpState {}

class UserOtpLoadingState extends SignUpState {}

class UserSignUpLoadingState extends SignUpState {}

