import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/model/post_model/post_model.dart';
import 'package:social_book/data/model/user_model/user_model.dart';
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
          kHeight(25),

          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Row(
              children: [
                Column(
                  children: [Icon(Icons.favorite_outline), Text('100 Likes')],
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Icon(Icons.comment_outlined),
                    Text('100 Comments')
                  ],
                ),
                SizedBox(
                  width: 90,
                ),
                Column(
                  children: [
                    Icon(Icons.bookmark_border),
                    SizedBox(
                      height: 20,
                    )
                  ],
                )
              ],
            ),
          ),
          kHeight(10),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Liked by ',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: 'Anil',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' and ',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: '100',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' Others',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
          kHeight(10),
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text('View all 57 commenets'),
          )
        ],
      ),
    );
  }
}
