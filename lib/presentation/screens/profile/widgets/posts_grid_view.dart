import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/screens/post_detail/post_details_screen.dart';
import 'package:social_book/presentation/screens/user/widgets/post_grid_image_tile.dart';


class PostsGridViewWidget extends StatelessWidget {
  const PostsGridViewWidget({
    super.key,
    required this.profileState,
  });

  final ProfileFetchingSucessState profileState;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: profileState.posts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            nextScreen(
              context,
              PostDetailsScreen(
                postModel: profileState.posts[index],
                userModel: profileState.userDetails,
              ),
            );
          },
          child: PostImageGridTile(
            imageUrl: profileState.posts[index].mediaURL![0],
          ),
        );
      },
      staggeredTileBuilder: (index) => StaggeredTile.count(
          (index % 7 == 3) ? 2 : 1, (index % 7 == 3) ? 2 : 1),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }
}

class PostEmtpyViewWidget extends StatelessWidget {
  const PostEmtpyViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kHeight(100),
        const Text(
          "You haven't posts yet!",
          style: TextStyle(
            fontSize: 18,
            fontVariations: fontWeightW600,
          ),
        ),
      ],
    );
  }
}
