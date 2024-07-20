import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/domine/repository/post_repo/post_repo.dart';

part 'saved_posts_event.dart';
part 'saved_posts_state.dart';

class SavedPostsBloc extends Bloc<SavedPostsEvent, SavedPostsState> {
    List<PostModel> savedPostList = [];
  SavedPostsBloc() : super(SavedPostsInitial()) {
    on<FetchAllSavedPostEvent>(fetchSavedPostEvent);
  }

    Future<void> fetchSavedPostEvent(
      FetchAllSavedPostEvent event, Emitter<SavedPostsState> emit) async {
    List<PostModel> savedPosts = await PostRepo.fetchAllSavedPost();
    if (savedPosts.isNotEmpty) {
      savedPostList.addAll(savedPosts);
      emit(FetchAllSavedPostSuccessState(savedPosts: savedPosts));
    } else {
      emit(FetchAllSavedPostErrorState());
    }
  }
}
