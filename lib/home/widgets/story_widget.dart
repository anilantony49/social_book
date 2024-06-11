import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_colors.dart';
import 'package:social_book/core/utils/constants.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            10,
            (index) => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: StoryList(),
                )), // Generate 10 StoryWidgets
      ),
    );
  }
}

class StoryList extends StatelessWidget {
  const StoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 70,
              height: 110,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/snaps at home (155).JPG'),
                    fit: BoxFit.cover,
                  ),
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.blackColor, width: 1)),
            ),
            Positioned(
              bottom: -14,
              left: 21,
              child: Container(
                width: 28,
                height: 40,
                decoration: BoxDecoration(
                  // color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black, // Border color
                    width: 1, // Border width
                  ),
                ),
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/myself.jpg'),
                  backgroundColor: Color(0xFFF2F2F2),
                  radius: 14,
                ),
              ),
            ),
          ],
        ),
        kHeight(10),
        const Text(
          'Anil',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
