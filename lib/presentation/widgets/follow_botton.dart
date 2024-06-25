import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_colors.dart';

class FollowBotton extends StatelessWidget {
  const FollowBotton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: AppColors.blackColor),
          borderRadius: BorderRadius.circular(3)),
      child: const Center(
        child: Text(
          'FOLLOW',
          style: TextStyle(
            fontSize: 10,
           fontWeight: FontWeight.w800,
            color: AppColors.blackColor,
          ),
        ),
      ),
    );
  }
}
