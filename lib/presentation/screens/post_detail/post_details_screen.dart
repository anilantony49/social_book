import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/screens/home/widgets/post/post_action_button_widget.dart';
import 'package:social_book/presentation/screens/home/widgets/post/post_image_widget.dart';
import 'package:social_book/presentation/screens/home/widgets/post/post_user_widget.dart';
import 'package:social_book/presentation/screens/post_detail/widgets/comment_text_field.dart';
import 'package:social_book/presentation/screens/post_detail/widgets/comments_section_widget.dart';
import 'package:social_book/presentation/widgets/custom_appbar.dart';

class PostDetailsScreen extends StatelessWidget {
  final PostModel postModel;
  final UserModel? userModel;
  PostDetailsScreen({
    super.key,
    required this.postModel,
    this.userModel,
  });

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: CustomAppbar(
              backgroundColor: Colors.white,
              title: 'Comments',
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            )),
        body: Column(
          children: [
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                children: [
                  // ============= Posted User Detial =============
                  PostUserWidget(
                    postModel: postModel,
                    userModel: userModel,
                  ),
                  kHeight(20),

                  // ============= Post Description =============
                  Text(
                    postModel.description,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 13),
                  ),
                  kHeight(10),

                  // ============= Post Image Widget =============

                  PostImageWidget(
                    postModel: postModel,
                    height: size.height * 0.5,
                    // onDetail: true,
                  ),
                  kHeight(5),

                  // ============= Post Action Buttons =============
                  // PostActionButtons(
                  //   postModel: postModel,
                  //   userModel: userModel!,
                  // ),

                  // ============= Comments View Section =============
                  CommentsSectionWidget(postModel: postModel),
                ],
              ),
            )),

            // ============= Comment Input Field =============
            CommentTextFieldWidget(
              postModel: postModel,
              onChanged: (p0) {
                scrollController.jumpTo(
                  scrollController.position.maxScrollExtent,
                );
              },
              onTap: () {
                scrollController.jumpTo(
                  scrollController.position.maxScrollExtent,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
