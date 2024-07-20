import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/domine/repository/post_repo/post_repo.dart';

part 'post_edit_event.dart';
part 'post_edit_state.dart';

class PostEditBloc extends Bloc<PostEditEvent, PostEditState> {
  PostEditBloc() : super(PostEditInitial()) {
     on<EditPostEvent>(_editPostEvent);
  }

    Future<void> _editPostEvent(
      EditPostEvent event, Emitter<PostEditState> emit) async {
    emit(EditPostLoadingState());
    String response = await PostRepo.editPost(event.postModel);
    if (response == 'success') {
      emit(EditPostSuccessState());
    } else {
      emit(EditPostErrorState());
    }
  }
}
