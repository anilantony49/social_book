part of 'like_unlike_bloc.dart';

@immutable
sealed class LikeUnlikeState {}

final class LikeUnlikeInitial extends LikeUnlikeState {}

class LikedPostState extends LikeUnlikeState {}

class UnlikedPostState extends LikeUnlikeState {}
