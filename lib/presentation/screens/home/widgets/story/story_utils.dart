import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/screens/explore/widget/shimmer_animate.dart';
import 'package:social_book/presentation/widgets/media_picker_page.dart';

class StoryUtils {
  static Widget loadingStoryCard(BuildContext context) {
    return ShimmerAnimate(
      child: Container(
        padding: const EdgeInsets.only(right: 5, left: 5),
        child: Column(
          children: [
            CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).colorScheme.onSurface),
            kHeight(10),
            // const Skelton(width: 50),
          ],
        ),
      ),
    );
  }

    static Widget emptyStoryView(BuildContext context, String? userId) {
    return GestureDetector(
      onTap: () {
      
        nextScreen(
          context,
          MediaPicker(
            maxCount: 1,
            requestType: RequestType.image,
            screenType: ScreenType.story,
            userId: userId,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(right: 5, left: 5),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 1, color: Theme.of(context).colorScheme.outline),
              ),
              child: const Icon(AppIcons.add),
            ),
            kHeight(5),
            const Text(
              'Create Story',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
