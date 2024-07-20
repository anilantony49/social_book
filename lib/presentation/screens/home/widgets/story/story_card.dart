import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/story_model/story_model.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_circle_widget.dart';
import 'package:social_book/presentation/widgets/fadein_animate.dart';


class StoryCard extends StatelessWidget {
  const StoryCard({
    super.key,
    required this.storyModel,
  });

  final StoryModel storyModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 5, left: 5),
      child: Column(
        children: [
          ProfileCircleWidget(
            radius: 60,
            imageWidget: storyModel.user['profile_picture'] == ""
                ? Image.asset(profilePlaceholder)
                : FadedImageLoading(
                    imageUrl: storyModel.user['profile_picture'],
                  ),
          ),
          kHeight(5),
          SizedBox(
            width: 70,
            child: Text(
              storyModel.user['username'].toString().toLowerCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
