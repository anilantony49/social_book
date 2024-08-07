import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_colors.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/story_model/story_model.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_circle_widget.dart';
import 'package:social_book/presentation/widgets/fadein_animate.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({
    super.key,
    required this.storyModel,
    required this.imageUrlList,
  });

  final StoryModel storyModel;
  final List<String> imageUrlList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 70,
              height: 110,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrlList[0]),
                    fit: BoxFit.cover,
                  ),
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.blackColor, width: 1)),
            ),
            Positioned(
              bottom: -35,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  ProfileCircleWidget(
                    radius: 30,
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
            ),
          ],
        ),
       kWidth(15)
      ],
    );
  }
}
