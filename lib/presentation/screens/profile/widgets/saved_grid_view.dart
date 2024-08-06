import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/presentation/bloc/saved_posts/saved_posts_bloc.dart';
import 'package:social_book/presentation/widgets/fadein_animate.dart';

class SavedGridViewWidget extends StatelessWidget {
  const SavedGridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedPostsBloc, SavedPostsState>(
      builder: (context, state) {
        if (state is FetchAllSavedPostSuccessState) {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1,
            ),
            
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.savedPosts.length,
            itemBuilder: (context, index) {
              return savedImageCard(savedPostState: state, index: index);
            },
          );
        }

        if (state is FetchAllSavedPostErrorState) {
          return const Center(child: Text('No saved images'));
        }
        return Container();
      },
    );
  }

  Widget savedImageCard({
    required FetchAllSavedPostSuccessState savedPostState,
    required int index,
  }) {
    String url = savedPostState.savedPosts[index].mediaURL![0];
    if (url.contains('image')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: FadedImageLoading(imageUrl: url),
      );
    }

    return Container();
  }
}
