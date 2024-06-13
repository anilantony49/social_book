import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/screens/home/widgets/header_widget.dart';
import 'package:social_book/presentation/screens/home/widgets/post_widget.dart';
import 'package:social_book/presentation/screens/home/widgets/story_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
          child: Column(
            children: [
              const HeaderWidget(),
              kHeight(15),
              const StoryWidget(),
              // kHeight(15),
              const PostWidget()
            ],
          ),
        )
      ],
    ));
  }
}
