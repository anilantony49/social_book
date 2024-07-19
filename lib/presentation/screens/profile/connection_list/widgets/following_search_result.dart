import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/bloc/search_follower/search_follower_bloc.dart';
import 'package:social_book/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:social_book/presentation/screens/user/user_profile_screen.dart';
import 'package:social_book/presentation/widgets/custom_outlined_button.dart';

class FollowingSearchResult extends StatelessWidget {
  const FollowingSearchResult({
    super.key,
    required this.state,
  });

  final SearchFollowingLoadedState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      shrinkWrap: true,
      itemCount: state.following.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            context
                .read<UserByIdBloc>()
                .add(FetchUserByIdEvent(userId: state.following[index]['_id']));
            nextScreen(
                context,
                UserProfileScreen(
                  userId: state.following[index]['_id'],
                  isCurrentUser: false,
                ));
          },
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: state.following[index]['profile_picture'] == ""
                  ? Image.asset(profilePlaceholder).image
                  : NetworkImage(
                      state.following[index]['profile_picture'],
                    ),
            ),
            title: Text(
              state.following[index]['fullname'],
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
            minVerticalPadding: 18,
            subtitle: Text(
              state.following[index]['username'],
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            trailing: SizedBox(
              width: 94,
              height: 30,
              child: CustomOutlinedBtn(
                onPressed: () {},
                btnText: 'VIEW',
              ),
            ),
          ),
        );
      },
    );
  }
}
