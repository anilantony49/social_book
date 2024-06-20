part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileFetchingLoadingState extends ProfileState {}

class ProfileFetchingSucessState extends ProfileState {
  final UserModel userDetails;

  ProfileFetchingSucessState({
    required this.userDetails,
  });
}

class ProfileFetchingErrorState extends ProfileState {}
