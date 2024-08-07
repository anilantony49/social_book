import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/bloc/story/story_bloc.dart';
import 'package:social_book/presentation/widgets/media_picker_page.dart';

import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class StoryHeadingWidget extends StatefulWidget {
  const StoryHeadingWidget({
    super.key,
  });

  @override
  State<StoryHeadingWidget> createState() => _StoryHeadingWidgetState();
}

class _StoryHeadingWidgetState extends State<StoryHeadingWidget> {
  String userId = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Row(
        children: [
          const Text(
            'Stories',
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          MultiBlocBuilder(
            blocs: [context.watch<StoryBloc>(), context.watch<ProfileBloc>()],
            builder: (context, state) {
              var state1 = state[0];
              var state2 = state[1];
              if (state2 is ProfileFetchingSucessState) {
                userId = state2.userDetails.id!;
              }
              if (state1 is FetchStoriesSuccessState) {
                return GestureDetector(
                  onTap: () {
                    nextScreen(
                      context,
                      MediaPicker(
                        maxCount: 1,
                        requestType: RequestType.image,
                        screenType: ScreenType.story,
                        userId: userId,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    child: const Icon(
                      AppIcons.add,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
