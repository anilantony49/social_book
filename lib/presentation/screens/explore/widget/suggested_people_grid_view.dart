import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:social_book/presentation/screens/explore/widget/loading_flw_btn.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_circle_widget.dart';
import 'package:social_book/presentation/screens/user/user_profile_screen.dart';
import 'package:social_book/presentation/screens/user/widgets/follow_button_widget.dart';
import 'package:social_book/presentation/widgets/fadein_animate.dart';

class SuggestedPeopleGridView extends StatelessWidget {
  const SuggestedPeopleGridView({
    super.key,
    required this.state,
    this.maxCount,
    this.isDetail = false,
    required this.reverse,
  });

  final UserDetailFetchingSuccessState state;
  final int? maxCount;
  final bool isDetail;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      physics: isDetail
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      shrinkWrap: true,
      crossAxisCount: 2,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      itemCount: maxCount ?? state.users.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            debugPrint('Go to profile');
            nextScreen(
                context,
                UserProfileScreen(
                  userId: state.users[index].id!,
                  isCurrentUser: false,
                ));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: kBoxShadow,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileCircleWidget(
                  radius: 60,
                  imageWidget: state.users[index].profilePicture == ""
                      ? Image.asset(profilePlaceholder)
                      : FadedImageLoading(
                          imageUrl: state.users[index].profilePicture!),
                ),
                kHeight(10),
                Text(state.users[index].fullName!),
                kHeight(2),
                Text(
                  '@${state.users[index].username!.toLowerCase()}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                kHeight(10),
                _followBtn(index)
              ],
            ),
          ),
        );
      },
    );
  }

  BlocBuilder<ProfileBloc, ProfileState> _followBtn(int index) {
    void followUnfollowFunction(
        UserModel currentUserModel, UserModel user, bool? isUnfollowing) {
      if (user.followers!.contains(currentUserModel) || isUnfollowing!) {
        state.users[index].followers!.removeWhere(
          (element) => element['_id'] == currentUserModel.id,
        );
      } else {
        state.users[index].followers!.add(currentUserModel.toJson());
      }
    }

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        if (profileState is ProfileFetchingSucessState) {
          return SizedBox(
            height: 35,
            width: double.infinity,
            child: FollowButton(
              userModel: state.users[index],
              onFollowUnfollow: followUnfollowFunction,
            ),
          );
        }
        return const LoadingFollowBtn();
      },
    );
  }
}
