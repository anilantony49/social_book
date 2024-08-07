import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/bloc/follow_unfollow_user/follow_unfollow_user_bloc.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/screens/user/widgets/custom_outlined_button.dart';

class FollowButton extends StatefulWidget {
  const FollowButton({
    super.key,
    this.userModel,
    this.onFollowUnfollow,
  });
  final UserModel? userModel;
  final void Function(UserModel, UserModel, bool)? onFollowUnfollow;

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  Set followersIds = {};
  Set followingIds = {};
  @override
  void initState() {
    followersIds = widget.userModel!.followers!
        .map((user) => user is Map<String, dynamic>
            ? user['_id'].toString()
            : user.toString())
        .toSet();
    followingIds = widget.userModel!.following!
        .map((user) => user is Map<String, dynamic>
            ? user['_id'].toString()
            : user.toString())
        .toSet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocBuilder(
        blocs: [
          context.watch<FollowUnfollowUserBloc>(),
          context.watch<ProfileBloc>()
        ],
        builder: (context, state) {
          var state2 = state[1];
          if (state2 is ProfileFetchingSucessState) {
            bool isFollowing = followersIds.contains(state2.userDetails.id);
            bool isFollowedByUser =
                followingIds.contains(state2.userDetails.id);
            return CustomOutlinedButton(
              onPressed: () {
                if (isFollowing) {
                  debugPrint('Unfollowed');
                  widget.onFollowUnfollow!(
                      state2.userDetails, widget.userModel!, true);
                  followersIds.remove(state2.userDetails.id);
                  context.read<FollowUnfollowUserBloc>().add(
                        UnfollowUserEvent(
                          userId: widget.userModel!.id!,
                          name: widget.userModel!.fullName!,
                        ),
                      );
                } else if (isFollowedByUser) {
                  debugPrint('Followed');
                  widget.onFollowUnfollow!(
                      state2.userDetails, widget.userModel!, false);
                  followersIds.add(state2.userDetails.id!);
                  context.read<FollowUnfollowUserBloc>().add(
                        FollowUserEvent(
                          userId: widget.userModel!.id!,
                          name: widget.userModel!.fullName!,
                        ),
                      );
                } else {
                  debugPrint('Followed');
                  widget.onFollowUnfollow!(
                      state2.userDetails, widget.userModel!, false);
                  followersIds.add(state2.userDetails.id!);
                  context.read<FollowUnfollowUserBloc>().add(
                        FollowUserEvent(
                          userId: widget.userModel!.id!,
                          name: widget.userModel!.fullName!,
                        ),
                      );
                }
              },
              btnText: isFollowing
                  ? 'UNFOLLOW'
                  : isFollowedByUser
                      ? 'FOLLOW BACK'
                      : 'FOLLOW',
            );
          }
          return Container();
        });
  }
}
