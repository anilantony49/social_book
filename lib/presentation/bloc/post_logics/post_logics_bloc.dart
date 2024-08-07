import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_book/domine/repository/cloud_repo/cloud_repo.dart';
import 'package:social_book/domine/repository/post_repo/post_repo.dart';

part 'post_logics_event.dart';
part 'post_logics_state.dart';

class PostLogicsBloc extends Bloc<PostLogicsEvent, PostLogicsState> {
  PostLogicsBloc() : super(PostLogicsInitial()) {
    on<CreatePostEvent>(_createPostEvent);
    on<RemovePostEvent>(_removePostEvent);
    on<SavePostEvent>(_savePostEvent);
    on<UnsavePostEvent>(_unsavePostEvent);
  }
  Future<void> _createPostEvent(
      CreatePostEvent event, Emitter<PostLogicsState> emit) async {
    emit(CreatePostLoadingState());
    String description = event.description;
    String location = event.location;
    List<String> imageUrlList =
        await CloudRepo.uploadImage(event.selectedAssets);
    String response =
        await PostRepo.createPost(location, description, imageUrlList);
    if (response == 'success' && imageUrlList.isNotEmpty) {
      emit(CreatePostSuccessState(imagePathList: imageUrlList));
    } else {
      emit(CreatePostErrorState());
    }
  }

  Future<void> _removePostEvent(
      RemovePostEvent event, Emitter<PostLogicsState> emit) async {
    emit(RemovePostLoadingState());
    String response = await PostRepo.removePost(event.postId);
    if (response == 'success') {
      emit(RemovePostSuccessState());
    } else {
      emit(RemovePostErrorState());
    }
  }

  Future<void> _savePostEvent(
      SavePostEvent event, Emitter<PostLogicsState> emit) async {
    String response = await PostRepo.savePost(event.postId);
    if (response == 'success') {
      emit(SavedPostSuccessState());
    }
  }

  Future<void> _unsavePostEvent(
      UnsavePostEvent event, Emitter<PostLogicsState> emit) async {
    String response = await PostRepo.unsavePost(event.postId);
    if (response == 'success') {
      emit(UnsavePostSuccessState());
    }
  }
}
