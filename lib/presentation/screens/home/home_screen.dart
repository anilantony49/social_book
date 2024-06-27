import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/bloc/post/post_bloc.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/screens/home/sections/post_section.dart';
import 'package:social_book/presentation/screens/home/widgets/header_widget.dart';
import 'package:social_book/presentation/screens/home/widgets/story/story_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Colors.white,
      child: Scaffold(
          body: RefreshIndicator(
        onRefresh: () => handleRefresh(context),
        child: ListView(
          // controller: homePageController,
          physics: const AlwaysScrollableScrollPhysics(),
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
                  const PostSection()
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  Future<void> handleRefresh(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<ProfileBloc>().add(ProfileInitialFetchEvent());
    // context.read<StoryBloc>().add(FetchAllStoriesEvent());
    context.read<PostBloc>().add(PostInitialFetchEvent());
  }
}
