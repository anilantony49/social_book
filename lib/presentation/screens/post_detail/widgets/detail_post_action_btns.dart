import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/bloc/comment/comment_bloc.dart';
import 'package:social_book/presentation/bloc/like_unlike_post/like_unlike_post_bloc.dart';
import 'package:social_book/presentation/widgets/custom_icon_button.dart';

class DetailPostActionBtns extends StatefulWidget {
  const DetailPostActionBtns({
    super.key,
    required this.postModel,
    required this.userModel,
  });

  final PostModel postModel;
  final UserModel userModel;

  @override
  State<DetailPostActionBtns> createState() => _DetailPostActionBtnsState();
}

class _DetailPostActionBtnsState extends State<DetailPostActionBtns> {
  late FToast fToast;

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            likePostButton(),
            Container(
              color: theme.colorScheme.outlineVariant,
              height: 15,
              width: 1,
            ),
            BlocBuilder<CommentBloc, CommentState>(
              builder: (context, state) {
                return CustomIconButton(
                  title: '${widget.postModel.comments!.length} comments',
                  icon: AppIcons.comment,
                  onTap: () {},
                );
              },
            ),
            Container(
              color: theme.colorScheme.outlineVariant,
              height: 15,
              width: 1,
            ),
            CustomIconButton(
              title: 'Share',
              icon: AppIcons.send_2,
              onTap: () {
                fToast.showToast(
                  child: customToast(context),
                  gravity: ToastGravity.BOTTOM,
                  toastDuration: const Duration(seconds: 2),
                );
              },
            ),
          ],
        ),
        Divider(
          height: 0,
          thickness: 0.5,
          color: theme.colorScheme.outlineVariant,
        ),
      ],
    );
  }

  BlocBuilder<LikeUnlikePostBloc, LikeUnlikePostState> likePostButton() {
    return BlocBuilder<LikeUnlikePostBloc, LikeUnlikePostState>(
      builder: (context, state) {
        return CustomIconButton(
          title: '${widget.postModel.likes!.length} likes',
          color: widget.postModel.likes!.contains(widget.userModel.id)
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.secondary,
          icon: widget.postModel.likes!.contains(widget.userModel.id)
              ? AppIcons.like
              : AppIcons.like,
          onTap: () {
            if (widget.postModel.likes!.contains(widget.userModel.id)) {
              widget.postModel.likes!.remove(widget.userModel.id.toString());
              context.read<LikeUnlikePostBloc>().add(
                    UnlikePostEvent(postId: widget.postModel.id!),
                  );
              debugPrint('unliking post');
            } else {
              widget.postModel.likes!.add(widget.userModel.id.toString());
              context.read<LikeUnlikePostBloc>().add(
                    LikePostEvent(postId: widget.postModel.id!),
                  );
              debugPrint('liking post');
            }
          },
        );
      },
    );
  }
}
