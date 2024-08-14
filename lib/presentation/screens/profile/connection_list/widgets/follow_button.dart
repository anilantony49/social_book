import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/bloc/follow_unfollow_user/follow_unfollow_user_bloc.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/screens/user/widgets/custom_outlined_button.dart';

class FollowButtonConnectionList extends StatefulWidget {
  const FollowButtonConnectionList({
    super.key,
    this.userModel,
    this.onFollowUnfollow,
  });

  final UserModel? userModel;
  final void Function(UserModel, UserModel, bool)? onFollowUnfollow;

  @override
  State<FollowButtonConnectionList> createState() =>
      _FollowButtonConnectionListState();
}

class _FollowButtonConnectionListState
    extends State<FollowButtonConnectionList> {
  late Set<String> followersIds;
  late Set<String> followingIds;

  @override
  void initState() {
    super.initState();
    followersIds = widget.userModel?.followers
            ?.map((user) => user is Map<String, dynamic> ? user['_id'].toString() : user.toString())
            .toSet() ??
        {};
    followingIds = widget.userModel?.following
            ?.map((user) => user is Map<String, dynamic> ? user['_id'].toString() : user.toString())
            .toSet() ??
        {};
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocBuilder(
      blocs: [
        context.watch<FollowUnfollowUserBloc>(),
        context.watch<ProfileBloc>()
      ],
      builder: (context, states) {
        final profileState = states[1];
        if (profileState is ProfileFetchingSucessState) {
          final isFollowing = followersIds.contains(profileState.userDetails.id);

          return CustomOutlinedButton(
            onPressed: () {
              if (isFollowing) {
                debugPrint('Unfollowed');
                widget.onFollowUnfollow?.call(
                    profileState.userDetails, widget.userModel!, true);
                followersIds.remove(profileState.userDetails.id);
                context.read<FollowUnfollowUserBloc>().add(
                      UnfollowUserEvent(
                        userId: widget.userModel!.id!,
                        name: widget.userModel!.fullName!,
                      ),
                    );
              }
               else {
                debugPrint('Followed');
                widget.onFollowUnfollow?.call(
                    profileState.userDetails, widget.userModel!, false);
                followersIds.add(profileState.userDetails.id!);
                context.read<FollowUnfollowUserBloc>().add(
                      FollowUserEvent(
                        userId: widget.userModel!.id!,
                        name: widget.userModel!.fullName!,
                      ),
                    );
              }
            },
            btnText: isFollowing ? 'UNFOLLOW' : 'FOLLOW',
          );
        }
        return Container();
      },
    );
  }
}
