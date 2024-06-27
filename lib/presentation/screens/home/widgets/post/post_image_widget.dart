import 'package:flutter/material.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/data/model/post_model/post_model.dart';
import 'package:social_book/presentation/widgets/fadein_animate.dart';
import 'package:social_book/presentation/screens/home/widgets/post/post_image_preview.dart';

class PostImageWidget extends StatelessWidget {
  final double height;
  final PostModel postModel;
  const PostImageWidget(
      {super.key, required this.height, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: PageView.builder(
          itemCount: postModel.mediaURL!.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                debugPrint('Image preview');
                nextScreen(
                  context,
                  PostImagePreview(
                    mediaUrl: postModel.mediaURL!,
                    currentIndex: index,
                  ),
                );
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                      tag: 'image-pre${postModel.mediaURL![0].toString()}',
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: FadedImageLoading(
                              imageUrl: postModel.mediaURL![index]),
                        ),
                      )),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      child: Text(
                        '${index + 1} / ${postModel.mediaURL!.length}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
