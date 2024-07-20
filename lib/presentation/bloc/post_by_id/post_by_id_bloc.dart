import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/domine/repository/post_repo/post_repo.dart';

part 'post_by_id_event.dart';
part 'post_by_id_state.dart';

class PostByIdBloc extends Bloc<PostByIdEvent, PostByIdState> {
  PostByIdBloc() : super(PostByIdInitial()) {
    on<FetchPostByIdEvent>(_fetchPostByIdEvent);
  }

  Future<void> _fetchPostByIdEvent(
      FetchPostByIdEvent event, Emitter<PostByIdState> emit) async {
    emit(FetchPostByIdLoadingState());
    PostModel? postModel = await PostRepo.fetchPostsById(event.postId);
    if (postModel != null) {
      emit(FetchPostByIdSuccessState(postModel: postModel));
    } else {
      emit(FetchPostByIdErrorState());
    }
  }
}
