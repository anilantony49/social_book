import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:social_book/domine/repository/post_repo/post_repo.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  LikeUnlikeBloc() : super(LikeUnlikeInitial()) {
    on<LikePostEvent>(_likePostEvent);
    on<UnlikePostEvent>(_unlikePostEvent);
  }

  Future<void> _likePostEvent(
      LikePostEvent event, Emitter<LikeUnlikeState> emit) async {
    String response = await PostRepo.likePost(event.postId);
    if (response == 'success') {
      emit(LikedPostState());
    } else {
      debugPrint('Error in like post');
    }
  }

  Future<void> _unlikePostEvent(
      UnlikePostEvent event, Emitter<LikeUnlikeState> emit) async {
    String response = await PostRepo.unlikePost(event.postId);
    if (response == 'success') {
      emit(UnlikedPostState());
    } else {
      debugPrint('Error in unlike post');
    }
  }
}
