

import 'package:flutter/material.dart';
import 'package:social_book/presentation/widgets/fadein_animate.dart';

class PostImageGridTile extends StatelessWidget {
  const PostImageGridTile({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    if (imageUrl.contains('image')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.onSurface,
          ),
          child: FadedImageLoading(imageUrl: imageUrl),
        ),
      );
    }
    return Container();
  }
}
