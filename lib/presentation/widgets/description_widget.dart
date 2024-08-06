import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
    required this.text,
    required this.postModel,
    required this.userModel,
  });

  final String text;
  final PostModel postModel;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var color = theme.colorScheme.secondary;
    return GestureDetector(
      onTap: () {
        // nextScreen(
        //     context,
        //     PostDetailsScreen(
        //       postModel: postModel,
        //       userModel: userModel,
        //     ));
      },
      child: ReadMoreText(
        text,
        trimLines: 3,
        textAlign: TextAlign.start,
        colorClickableText: Colors.pink,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'more',
        trimExpandedText: ' less',
        style: const TextStyle(fontSize: 13),
        lessStyle: TextStyle(fontSize: 13, color: color),
        moreStyle: TextStyle(fontSize: 13, color: color),
      ),
    );
  }
}
