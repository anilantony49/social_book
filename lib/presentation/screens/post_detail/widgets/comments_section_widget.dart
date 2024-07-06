import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/model/post_model/post_model.dart';
import 'package:social_book/presentation/bloc/comment/comment_bloc.dart';
import 'package:social_book/presentation/screens/post_detail/widgets/comment_card_widget.dart';

class CommentsSectionWidget extends StatelessWidget {
  final PostModel postModel;
  const CommentsSectionWidget({
    super.key,
    required this.postModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        return postModel.comments!.isEmpty
            ? Column(
                children: [
                  kHeight(70),
                  const Center(
                    child: Text(
                      'No comments!',
                      style: TextStyle(
                        fontSize: 16,
                        fontVariations: fontWeightW600,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  kHeight(70),
                ],
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: postModel.comments!.length,
                itemBuilder: (context, index) {
                  return CommentCardWidget(
                    commentModel: postModel.comments![index],
                    postModel: postModel,
                  );
                },
              );
      },
    );
  }
}
