import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/model/post_model/post_model.dart';
import 'package:social_book/presentation/screens/home/widgets/post/post_image_widget.dart';

class PostListWidget extends StatelessWidget {
  final PostModel postModel;
  const PostListWidget({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: Container(
          width: 340,
          height: 480,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 215, 214, 214),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 15, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Posted User Details

            kHeight(15),

            // Post Description
            kHeight(15),

            // Post Image Section

            PostImageWidget(
              postModel: postModel,
              height: MediaQuery.of(context).size.height / 2.2,
            ),
            kHeight(10),

            const Row(
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
            kHeight(10),
            RichText(
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
            kHeight(10),
            const Text('View all 57 commenets')
          ],
        ),
      ),
    ]);
  }
}
