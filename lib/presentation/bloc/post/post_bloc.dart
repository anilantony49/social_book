import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/domine/repository/post_repo/post_repo.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitialState()) {
    on<PostInitialFetchEvent>(postInitialFetchEvent);
  }

  FutureOr<void> postInitialFetchEvent(
      PostInitialFetchEvent event, Emitter<PostState> emit) async {
    emit(PostDetailFetchingLoadingState());
    List<PostModel> posts = await PostRepo.fetchAllPosts();
    if (posts.isNotEmpty) {
      emit(PostDetailFetchingSucessState(posts: posts));
    } else {
      emit(PostDetailFetchingErrorState());
    }
  }
}
