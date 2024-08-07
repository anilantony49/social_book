import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/bloc/saved_posts/saved_posts_bloc.dart';
import 'package:social_book/presentation/screens/home/widgets/post/post_action_button_widget.dart';
import 'package:social_book/presentation/screens/home/widgets/post/post_image_widget.dart';
import 'package:social_book/presentation/screens/home/widgets/post/post_user_widget.dart';
import 'package:social_book/presentation/widgets/description_widget.dart';

class PostListWidget extends StatelessWidget {
  final PostModel postModel;
  final UserModel userModel;

  const PostListWidget(
      {super.key, required this.postModel, required this.userModel});

  @override
  Widget build(BuildContext context) {
    // List<PostModel> savedPostList = [];
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 4),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 242, 235, 235),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Posted User Details
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: PostUserWidget(
              postModel: postModel,
              userModel: userModel,
            ),
          ),
          kHeight(10),
          // Post Description
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: DescriptionWidget(
              text: postModel.description,
              postModel: postModel,
              userModel: userModel,
            ),
          ),
          kHeight(10),
          // Post Image Section

          PostImageWidget(
            postModel: postModel,
            height: MediaQuery.of(context).size.height / 2.2,
          ),
          kHeight(15),
          BlocBuilder<SavedPostsBloc, SavedPostsState>(
            builder: (context, state) {
              if (state is FetchAllSavedPostSuccessState) {
                List<PostModel> savedPostList = state.savedPosts;
                return PostActionButtons(
                  postModel: postModel,
                  userModel: userModel,
                  savedPostList: savedPostList,
                );
              }
              List<PostModel> savedPostList = [];
              return PostActionButtons(
                  postModel: postModel,
                  userModel: userModel,
                  savedPostList: savedPostList);
            },
          ),
        ],
      ),
    );
  }
}
