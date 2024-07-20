import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:social_book/domine/repository/post_repo/post_repo.dart';

part 'like_unlike_post_event.dart';
part 'like_unlike_post_state.dart';

class LikeUnlikePostBloc
    extends Bloc<LikeUnlikePostEvent, LikeUnlikePostState> {
  LikeUnlikePostBloc() : super(LikeUnlikePostInitial()) {
    on<LikePostEvent>(likePostEvent);
    on<UnlikePostEvent>(unlikePostEvent);
  }

  Future<void> likePostEvent(
      LikePostEvent event, Emitter<LikeUnlikePostState> emit) async {
    String response = await PostRepo.likePost(event.postId);
    if (response == 'success') {
      emit(LikedPostState());
    } else {
      debugPrint('Error in like post');
    }
  }

  Future<void> unlikePostEvent(
      UnlikePostEvent event, Emitter<LikeUnlikePostState> emit) async {
    String response = await PostRepo.unlikePost(event.postId);
    if (response == 'success') {
      emit(UnlikedPostState());
    } else {
      debugPrint('Error in unlike post');
    }
  }
}
