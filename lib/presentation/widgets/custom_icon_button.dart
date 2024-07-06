import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';

class CustomIconButton extends StatelessWidget {
  final void Function()? onTap;
  final IconData icon;
  final Color? color;
  final String title;
  const CustomIconButton({
    super.key,
    required this.onTap,
    this.color,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color ?? Colors.black),
            kWidth(5),
            Text(
              title,
              style: const TextStyle(fontSize: 13, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
