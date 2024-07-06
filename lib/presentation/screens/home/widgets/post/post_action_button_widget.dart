import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/data/model/post_model/post_model.dart';
import 'package:social_book/data/model/user_model/user_model.dart';
import 'package:social_book/presentation/bloc/like_unlike/like_unlike_bloc.dart';
import 'package:social_book/presentation/widgets/custom_icon_button.dart';

class PostActionButtons extends StatefulWidget {
  final PostModel postModel;
  final UserModel userModel;
  const PostActionButtons({
    super.key,
    required this.postModel,
    required this.userModel,
  });

  @override
  State<PostActionButtons> createState() => _PostActionButtonsState();
}

class _PostActionButtonsState extends State<PostActionButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        children: [
          likeButton(),
          commentButton(context),
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
              : Colors.blue,
          icon: widget.postModel.likes!.contains(widget.userModel.id)
              ? Icons.favorite_border
              : Icons.favorite,
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
        return CustomIconBtn(
          title: '${widget.postModel.comments!.length} comments',
          icon: Ktweel.comment,
          onTap: () {
            debugPrint('Comment pressed');
            nextScreen(
              context,
              PostDetailPage(
                postModel: widget.postModel,
                userModel: widget.userModel,
              ),
            ).then((value) => mySystemTheme(context));
          },
        );
      },
    );
  }
}
