import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/presentation/bloc/story/story_bloc.dart';
import 'package:social_book/presentation/cubit/post_image_index.dart/post_image_index.dart';
import 'package:social_book/presentation/screens/profile/edit_profile/widgets/custom_text_button.dart';

import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class StoryImagePreviewPage extends StatelessWidget {
  const StoryImagePreviewPage({
    super.key,
    required this.mediaUrl,
    required this.userId,
  });

  final List<AssetEntity> mediaUrl;
  final String userId;

  @override
  Widget build(BuildContext context) {
    // changeSystemThemeOnPopup(context: context, color: lBlack);

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
            title: const Text(
              'Story Preview',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            actions: [
              BlocBuilder<StoryBloc, StoryState>(
                builder: (context, state) {
                  return state is AddStoryLoadingState
                      ? Container(
                          height: 15,
                          width: 15,
                          margin: const EdgeInsets.only(right: 10),
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.onPrimary,
                            strokeWidth: 2,
                          ),
                        )
                      : CustomTextButton(
                          onTap: () async {
                            context.read<StoryBloc>().add(AddStoryEvent(
                                  userId: userId,
                                  selectedAssets: mediaUrl,
                                ));
                          },
                          buttonText: 'SHARE',
                        );
                },
              ),
            ],
          ),
          body: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: AssetEntityImage(
                mediaUrl[0],
                isOriginal: true,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      AppIcons.info_rugged,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
