import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:social_book/domine/repository/user_repo/user_repo.dart';

part 'follow_unfollow_user_event.dart';
part 'follow_unfollow_user_state.dart';

class FollowUnfollowUserBloc
    extends Bloc<FollowUnfollowUserEvent, FollowUnfollowUserState> {
  FollowUnfollowUserBloc() : super(FollowUnfollowUserInitial()) {
    on<FollowUserEvent>(_followUserEvent);
    on<UnfollowUserEvent>(_unfollowUserEvent);
  }

  Future<void> _followUserEvent(
      FollowUserEvent event, Emitter<FollowUnfollowUserState> emit) async {
    FollowUnfollowModel response = await UserRepo.followUser(event.userId);
    if (response.message == 'success') {
      debugPrint('Followed user: ${event.name} ${event.userId}');
      emit(FollowedUserState(
        followersList: response.followers,
        followingList: response.following,
      ));
    }
  }

  Future<void> _unfollowUserEvent(
      UnfollowUserEvent event, Emitter<FollowUnfollowUserState> emit) async {
    FollowUnfollowModel response = await UserRepo.unfollowUser(event.userId);
    if (response.message == 'success') {
      debugPrint('Unfollowed user: ${event.name} ${event.userId}');
      emit(UnfollowedUserState(
        followersList: response.followers,
        followingList: response.following,
      ));
    }
  }
}
