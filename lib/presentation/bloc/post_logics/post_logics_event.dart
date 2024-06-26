part of 'post_logics_bloc.dart';

@immutable
sealed class PostLogicsEvent {}

class CreatePostEvent extends PostLogicsEvent {
  final String location;
  final String description;
  final List<AssetEntity> selectedAssets;

  CreatePostEvent({
    required this.location,
    required this.description,
    required this.selectedAssets,
  });
}
