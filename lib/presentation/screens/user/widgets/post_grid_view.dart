import 'package:flutter/material.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:social_book/presentation/screens/post_detail/post_details_screen.dart';
import 'package:social_book/presentation/screens/user/widgets/post_grid_image_tile.dart';

class PostGridView extends StatelessWidget {
  const PostGridView({
    super.key,
    required this.state,
  });

  final FetchUserByIdSuccessState state;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return state.posts.isNotEmpty
        ? GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  nextScreen(
                    context,
                    PostDetailsScreen(
                      postModel: state.posts[index],
                      userModel: state.userModel,
                    ),
                  );
                },
                child: PostImageGridTile(
                  imageUrl: state.posts[index].mediaURL![0],
                ),
              );
            },
          )
        : Column(
            children: [
              kHeight(80),
              const Text(
                "No posts yet!",
                style: TextStyle(
                  fontSize: 18,
                  fontVariations: fontWeightW600,
                ),
              ),
              kHeight(5),
              Text(
                "This user hasn't shared anything \nwith the community!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSecondary,
                ),
              ),
            ],
          );
  }
}
