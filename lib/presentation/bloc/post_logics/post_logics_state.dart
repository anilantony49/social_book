part of 'post_logics_bloc.dart';

@immutable
sealed class PostLogicsState {}

final class PostLogicsInitial extends PostLogicsState {}

class CreatePostLoadingState extends PostLogicsState {}

class CreatePostSuccessState extends PostLogicsState {
  final List<String> imagePathList;

  CreatePostSuccessState({
    required this.imagePathList,
  });
}

class CreatePostErrorState extends PostLogicsState {}
