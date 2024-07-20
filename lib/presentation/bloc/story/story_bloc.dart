import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_book/data/models/story_model/story_model.dart';
import 'package:social_book/domine/repository/cloud_repo/cloud_repo.dart';
import 'package:social_book/domine/repository/story_repo/story_repo.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc() : super(StoryInitialState()) {
    on<FetchAllStoriesEvent>(_fetchAllStoriesEvent);
    on<AddStoryEvent>(_addStoryEvent);
  }

  Future<void> _fetchAllStoriesEvent(
      FetchAllStoriesEvent event, Emitter<StoryState> emit) async {
    emit(FetchStoriesLoadingState());
    List<StoryModel> storiesList = await StoryRepo.getAllStories();
    if (storiesList.isNotEmpty) {
      emit(FetchStoriesSuccessState(storiesList: storiesList));
    } else {
      emit(FetchStoriesErrorState());
    }
  }

  Future<void> _addStoryEvent(
      AddStoryEvent event, Emitter<StoryState> emit) async {
    emit(AddStoryLoadingState());
    List<String> imageUrlList =
        await CloudRepo.uploadImage(event.selectedAssets);
    String result = await StoryRepo.addStory(event.userId, imageUrlList[0]);
    if (result == 'success') {
      emit(AddStorySucessState());
    } else {
      emit(AddStoryErrorState());
    }
  }
}
