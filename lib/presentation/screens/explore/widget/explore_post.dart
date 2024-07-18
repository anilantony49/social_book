import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/data/model/post_model/post_model.dart';
import 'package:social_book/presentation/bloc/post/post_bloc.dart';
import 'package:social_book/presentation/screens/explore/widget/explore_loading.dart';
import 'package:social_book/presentation/screens/post_detail/post_details_screen.dart';
import 'package:social_book/presentation/widgets/grid_tile.dart';

class ExplorePost extends StatelessWidget {
  const ExplorePost({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostInitialState) {
          context.read<PostBloc>().add(PostInitialFetchEvent());
        }
        if (state is PostDetailFetchingLoadingState) {
          return Column(
            children: [
              _titleWidget(context),
              const ExplorePostLoading(),
            ],
          );
        }
        if (state is PostDetailFetchingSucessState) {
          return Column(
            children: [_titleWidget(context), _postGridView(state, context)],
          );
        }
        return const Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Text('No post to show you'),
        );
      },
    );
  }
}

Widget _titleWidget(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width / 2,
    child: const Stack(
      fit: StackFit.loose,
      children: [
        Align(
            child: Text('Explore Post',
                style: TextStyle(fontSize: 18, height: 1.7)))
      ],
    ),
  );
}

GridView _postGridView(
    PostDetailFetchingSucessState state, BuildContext context) {
  final size = MediaQuery.of(context).size;
  return GridView.builder(
    padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      childAspectRatio: 0.75, 
    ),
    itemCount: state.posts.length,
    itemBuilder: (context, index) {
      PostModel post = state.posts[index];
      final isImage = post.mediaURL![0].toString().contains('image');
      final url = post.mediaURL![0];

      if (isImage) {
        double height;
        if (index % 2 == 0) {
          height = size.height * 0.26;
        } else if (index % 3 == 0) {
          height = size.height * 0.22;
        } else {
          height = size.height * 0.24;
        }
        return ImageTile(
          onTap: () {
            nextScreen(
              context,
              PostDetailsScreen(
                postModel: post,
                userModel: post.user,
              ),
            );
          },
          height: height,
          image: url,
        );
      }

      return Container();
    },
  );
}
