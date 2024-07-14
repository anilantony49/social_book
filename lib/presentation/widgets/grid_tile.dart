import 'package:flutter/material.dart';
import 'package:social_book/presentation/widgets/fadein_animate.dart';

class ImageTile extends StatelessWidget {
  const ImageTile({
    super.key,
    required this.height,
    required this.image,
    required this.onTap,
  });

  final double height;
  final String image;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface,
          borderRadius: BorderRadius.circular(6),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: FadeInAnimate(
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
