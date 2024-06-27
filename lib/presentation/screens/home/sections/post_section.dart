import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/presentation/bloc/post/post_bloc.dart';
import 'package:social_book/presentation/screens/home/widgets/post/empty_post_widget.dart';
import 'package:social_book/presentation/screens/home/widgets/post/post_list_widget.dart';

class PostSection extends StatelessWidget {
  const PostSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostDetailFetchingSucessState) {
            return Column(
              children: List.generate(
                  state.posts.length,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PostListWidget(
                          postModel: state.posts[index],
                        ),
                      )),
            );
          }
          if (state is PostDetailFetchingErrorState) {
            return const EmptyPostWidget();
          }
          return Container();
        },
      ),
    );
  }
}
