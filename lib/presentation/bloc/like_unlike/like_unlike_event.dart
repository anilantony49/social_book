part of 'like_unlike_bloc.dart';

@immutable
sealed class LikeUnlikeEvent {}

class LikePostEvent extends LikeUnlikeEvent {
  final String postId;

  LikePostEvent({
    required this.postId,
  });
}

class UnlikePostEvent extends LikeUnlikeEvent {
  final String postId;

  UnlikePostEvent({
    required this.postId,
  });
}
