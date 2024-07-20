import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_icons.dart';

class CustomAppbar2 extends StatelessWidget {
  const CustomAppbar2({
    super.key,
    required this.title,
    required this.onPressed,
    required this.backgroundColor,
  });

  final String title;
  final void Function()? onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      leading: IconButton(
        onPressed: onPressed,
        icon: const Icon(AppIcons.arrow_left, size: 24),
      ),
      titleSpacing: 0,
    );
  }
}
