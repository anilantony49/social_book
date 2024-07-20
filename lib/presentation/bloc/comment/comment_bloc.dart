import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/domine/repository/post_repo/post_repo.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial()) {
    on<AddCommentEvent>(addCommentEvent);
    on<DeleteCommentEvent>(deleteCommentEvent);
  }

  Future<void> addCommentEvent(
      AddCommentEvent event, Emitter<CommentState> emit) async {
    CommentModel? commentModel =
        await PostRepo.addComment(event.comment, event.postId);
    if (commentModel != null) {
      event.postModel.comments!.add(
        CommentModel(
          user: event.userModel,
          comment: event.comment,
          createdDate: DateTime.now().toString(),
        ),
      );
      emit(CommentAddedState(commentModel: commentModel));
    }
  }

  Future<void> deleteCommentEvent(
      DeleteCommentEvent event, Emitter<CommentState> emit) async {
    String response =
        await PostRepo.deleteComment(event.commentId, event.postId);
    if (response == 'success') {
      event.postModel.comments!
          .removeWhere((element) => element.id == event.commentId);
      emit(CommentDeletedState(commentId: event.commentId));
    }
  }
}
