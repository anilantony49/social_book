import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/screens/profile/widgets/posts_grid_view.dart';
import 'package:social_book/presentation/screens/profile/widgets/saved_grid_view.dart';

class CustomTabviewWidget extends StatelessWidget {
  const CustomTabviewWidget({
    super.key,
    required this.tabController,
    required this.profileState,
  });
  final ProfileFetchingSucessState profileState;
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return AutoScaleTabBarView(
      controller: tabController,
      children: [
        if (profileState.posts.isNotEmpty)
          PostsGridViewWidget(profileState: profileState)
        else
          const PostEmtpyViewWidget(),
          const SavedGridViewWidget()
      ],
    );
  }
}
