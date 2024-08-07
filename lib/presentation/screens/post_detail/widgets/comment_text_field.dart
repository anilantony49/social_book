import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/presentation/bloc/comment/comment_bloc.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';

class CommentTextFieldWidget extends StatefulWidget {
  const CommentTextFieldWidget({
    super.key,
    required this.postModel,
    required this.onTap,
    required this.onChanged,
  });

  final PostModel postModel;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  @override
  State<CommentTextFieldWidget> createState() => _CommentTextFieldWidgetState();
}

class _CommentTextFieldWidgetState extends State<CommentTextFieldWidget> {
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileFetchingSucessState) {
          return BottomAppBar(
            padding: EdgeInsets.zero,
            elevation: 0,
            notchMargin: 0,
            height: 60,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: theme.colorScheme.outlineVariant,
                  ),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: state.userDetails.profilePicture == ""
                        ? Image.asset(profilePlaceholder).image
                        : NetworkImage(state.userDetails.profilePicture!),
                  ),
                  kWidth(10),
                  Expanded(
                    child: TextFormField(
                      onTap: widget.onTap,
                      onChanged: widget.onChanged,
                      controller: commentController,
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        hintStyle:
                            TextStyle(color: theme.colorScheme.secondary),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      context.read<CommentBloc>().add(AddCommentEvent(
                            postId: widget.postModel.id!,
                            comment: commentController.text,
                            postModel: widget.postModel,
                            userModel: state.userDetails,
                          ));
                      commentController.clear();
                    },
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
