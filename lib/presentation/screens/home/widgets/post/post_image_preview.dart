import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/presentation/cubit/post_image_index.dart/post_image_index.dart';

class PostImagePreview extends StatefulWidget {
  const PostImagePreview({
    super.key,
    required this.mediaUrl,
    required this.currentIndex,
  });

  final List mediaUrl;
  final int currentIndex;

  @override
  State<PostImagePreview> createState() => _PostImagePreviewState();
}

class _PostImagePreviewState extends State<PostImagePreview> {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.currentIndex);
    if (widget.currentIndex != 0) {
      context.read<PostImageIndexCubit>().onPageChange(widget.currentIndex);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostImageIndexCubit, int>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                AppIcons.close,
                size: 30,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            title: Text(
              '${state + 1} / ${widget.mediaUrl.length}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          body: GestureDetector(
            onVerticalDragUpdate: (details) {
              int sensitivity = 8;
              if (details.delta.dy > sensitivity) {
                Navigator.pop(context);
              }
            },
            child: PageView.builder(
              controller: pageController,
              itemCount: widget.mediaUrl.length,
              onPageChanged: (value) {
                context.read<PostImageIndexCubit>().onPageChange(value);
              },
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  boundaryMargin: const EdgeInsets.all(20.0),
                  minScale: 0.1,
                  maxScale: 5.0,
                  trackpadScrollCausesScale: true,
                  child: Image(
                    image: NetworkImage(
                      widget.mediaUrl[index],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
