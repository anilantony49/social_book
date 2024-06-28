import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/data/model/post_model/post_model.dart';
import 'package:social_book/presentation/bloc/post/post_bloc.dart';
import 'package:social_book/presentation/bloc/post_logics/post_logics_bloc.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/screens/home/widgets/post/edit_post_widget.dart';

class PostMoreBottomSheet extends StatefulWidget {
  final PostModel postModel;
  final String userId;
  final String postId;
  const PostMoreBottomSheet(
      {super.key,
      required this.postModel,
      required this.userId,
      required this.postId});

  @override
  State<PostMoreBottomSheet> createState() => _PostMoreBottomSheetState();
}

class _PostMoreBottomSheetState extends State<PostMoreBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.all(20),
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          // =========== If post is of current user ===========
          (widget.postModel.user!.id ?? widget.postId) == widget.userId
              ? Column(
                  children: [
                    editPostWidget(context),
                    removePostWidget(context),
                  ],
                )
              : const SizedBox(),

          // =========== else ===========
          (widget.postModel.user!.id ?? widget.postId) != widget.userId
              ? Column(
                  children: [
                    // reportPostWidget(), viewAccountWidget()
                    ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }

    Widget removePostWidget(BuildContext context) {
    return BlocListener<PostLogicsBloc, PostLogicsState>(
      listener: (context, state) {
        if (state is RemovePostSuccessState) {
          Navigator.pop(context);
          Navigator.pop(context);
          // if (widget.onDetail) Navigator.pop(context);
          context.read<PostBloc>().add(PostInitialFetchEvent());
          context.read<ProfileBloc>().add(ProfileInitialFetchEvent());
        }
      },
      child: ListTile(
        leading: const Icon(AppIcons.remove_2),
        title: const Text('Remove post'),
        onTap: () {
          // if (widget.onDetail) {
          //   changeSystemThemeOnPopup(
          //     color: Theme.of(context).colorScheme.tertiary,
          //     context: context,
          //   );
          // } else {
          //   changeSystemThemeOnPopup(
          //     color: Theme.of(context).colorScheme.onTertiary,
          //     context: context,
          //   );
          // }
          showDialog(
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                title: 'Are you sure?',
                description:
                    'This will delete this post permanently, You cannot undo this action',
                actionBtnTxt: 'Remove',
                popBtnText: 'Cancel',
                onTap: () {
                  context.read<PostLogicsBloc>().add(
                        RemovePostEvent(
                          postId: widget.postModel.id!,
                        ),
                      );
                },
              );
            },
          );
          // .then((value) {
          //   if (widget.onDetail) {
          //     changeSystemThemeOnPopup(
          //       color: Theme.of(context).colorScheme.background,
          //       context: context,
          //     );
          //   } else {
          //     changeSystemThemeOnPopup(
          //       color: Theme.of(context).colorScheme.onBackground,
          //       context: context,
          //     );
          //   }
          // });
        },
      ),
    );
  }
}
