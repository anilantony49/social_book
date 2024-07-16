import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/data/model/post_model/post_model.dart';
import 'package:social_book/data/model/user_model/user_model.dart';
import 'package:social_book/presentation/bloc/comment/comment_bloc.dart';
import 'package:social_book/presentation/bloc/like_unlike/like_unlike_bloc.dart';
import 'package:social_book/presentation/bloc/post_logics/post_logics_bloc.dart';
import 'package:social_book/presentation/bloc/saved_posts/saved_posts_bloc.dart';
import 'package:social_book/presentation/screens/post_detail/post_details_screen.dart';
import 'package:social_book/presentation/widgets/custom_icon_button.dart';

class PostActionButtons extends StatefulWidget {
  final PostModel postModel;
  final UserModel userModel;
  final List<PostModel> savedPostList;
  const PostActionButtons({
    super.key,
    required this.postModel,
    required this.userModel,
    required this.savedPostList,
  });

  @override
  State<PostActionButtons> createState() => _PostActionButtonsState();
}

class _PostActionButtonsState extends State<PostActionButtons> {
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    if (widget.savedPostList.isEmpty) {
      isSaved = false;
    }
    for (int i = 0; i < widget.savedPostList.length; i++) {
      if (widget.savedPostList[i].id == widget.postModel.id) {
        isSaved = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        children: [
          likeButton(),
          commentButton(context),
          const Spacer(),
          Flexible(child: savePost()),
          // savePost()
          // const Column(
          //   children: [Icon(Icons.favorite_outline), Text('100 Likes')],
          // ),
          // const SizedBox(
          //   width: 30,
          // ),
          // const Column(
          //   children: [Icon(Icons.comment_outlined), Text('100 Comments')],
          // ),
          // const SizedBox(
          //   width: 90,
          // ),
          // const Column(
          //   children: [
          //     Icon(Icons.bookmark_border),
          //     SizedBox(
          //       height: 20,
          //     )
          //   ],
          // )
        ],
      ),
    );
  }

  Widget likeButton() {
    return BlocBuilder<LikeUnlikeBloc, LikeUnlikeState>(
      builder: (context, state) {
        return CustomIconButton(
          title: '${widget.postModel.likes!.length} likes',
          color: widget.postModel.likes!.contains(widget.userModel.id)
              ? Colors.red
              : Colors.black,
          icon: widget.postModel.likes!.contains(widget.userModel.id)
              ? Icons.favorite
              : Icons.favorite_border,
          onTap: () {
            if (widget.postModel.likes!.contains(widget.userModel.id)) {
              widget.postModel.likes!.remove(widget.userModel.id.toString());
              context.read<LikeUnlikeBloc>().add(
                    UnlikePostEvent(postId: widget.postModel.id!),
                  );
              debugPrint('Unliking post');
            } else {
              widget.postModel.likes!.add(widget.userModel.id.toString());
              context.read<LikeUnlikeBloc>().add(
                    LikePostEvent(postId: widget.postModel.id!),
                  );
              debugPrint('Liking post');
            }
          },
        );
      },
    );
  }

  Widget commentButton(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        return CustomIconButton(
          title: '${widget.postModel.comments!.length} comments',
          icon: Icons.comment,
          onTap: () {
            debugPrint('Comment pressed');
            nextScreen(
              context,
              PostDetailsScreen(
                postModel: widget.postModel,
                userModel: widget.userModel,
              ),
            );
          },
        );
      },
    );
  }

  Widget savePost() {
    return BlocConsumer<PostLogicsBloc, PostLogicsState>(
      listener: (context, state) {
        if (state is SavedPostSuccessState) {
          debugPrint('Saved post is success');
          context.read<SavedPostsBloc>().add(FetchAllSavedPostEvent());
        }
        if (state is UnsavePostSuccessState) {
          debugPrint('Unsaved post is success');

          context.read<SavedPostsBloc>().add(FetchAllSavedPostEvent());
        }
      },
      builder: (context, state) {
        return CustomIconButton(
          onTap: () {
            if (isSaved) {
              isSaved = false;
              context
                  .read<PostLogicsBloc>()
                  .add(UnsavePostEvent(postId: widget.postModel.id!));
            } else {
              isSaved = true;
              context
                  .read<PostLogicsBloc>()
                  .add(SavePostEvent(postId: widget.postModel.id!));
            }
          },
          icon: isSaved ? Icons.bookmark : Icons.bookmark_border,
          title: '',
        );
      },
    );
  }
}
