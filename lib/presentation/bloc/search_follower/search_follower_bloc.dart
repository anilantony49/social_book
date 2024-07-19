import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_follower_event.dart';
part 'search_follower_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchFollowerInitial()) {
    on<SearchFollowerEvent>(_searchFollowerEvent);
    on<SearchFollowingEvent>(_searchFollowingEvent);
  }

  Future<void> _searchFollowerEvent(
      SearchFollowerEvent event, Emitter<SearchState> emit) async {
    emit(SearchFollowerLoadingState());
    List searchedList = [];
    Set<String> userIds = {};
    for (var element in event.followers) {
      final String userId = element['_id'];
      final String fullname = element['fullname'].toLowerCase();
      final String username = element['username'].toLowerCase();
      final String searchTerm = event.query.toLowerCase();
      if (fullname.contains(searchTerm) || username.contains(searchTerm)) {
        if (!userIds.contains(userId)) {
          userIds.add(userId);
          searchedList.add(element);
        }
      }
    }
    emit(SearchFollowerLoadedState(followers: searchedList));
  }

  Future<void> _searchFollowingEvent(
      SearchFollowingEvent event, Emitter<SearchState> emit) async {
    emit(SearchFollowingLoadingState());
    List searchedList = [];
    Set<String> userIds = {};
    for (var element in event.following) {
      final String userId = element['_id'];
      final String fullname = element['fullname'].toLowerCase();
      final String username = element['username'].toLowerCase();
      final String searchTerm = event.query.toLowerCase();
      if (fullname.contains(searchTerm) || username.contains(searchTerm)) {
        if (!userIds.contains(userId)) {
          userIds.add(userId);
          searchedList.add(element);
        }
      }
    }
    emit(SearchFollowingLoadedState(following: searchedList));
  }
}
