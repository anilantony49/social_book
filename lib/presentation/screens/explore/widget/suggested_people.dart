import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_colors.dart';
import 'package:social_book/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:social_book/presentation/screens/explore/widget/all_suggested_user_page.dart';
import 'package:social_book/presentation/screens/explore/widget/suggested_people_grid_view.dart';

class SuggestedPeople extends StatelessWidget {
  const SuggestedPeople({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserInitial) {
          context.read<UserBloc>().add(FetchAllUserEvent());
        }

        if (state is UserDetailFetchingLoadingState) {
          return Column(
            children: [
              suggestedHeading(context),
            ],
          );
        }
        if (state is UserDetailFetchingSuccessState) {
          return Column(
            children: [
              suggestedHeading(state: state, context),
              SuggestedPeopleGridView(
                state: state,
                maxCount: 4,
                reverse: true,
              ),
            ],
          );
        }
        return const Center(
          child: Text('No data'),
        );
      },
    );
  }
}

Widget suggestedHeading(BuildContext context,
    {UserDetailFetchingSuccessState? state}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Row(
      children: [
        const Text(
          'Suggested People',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            if (state != null) {
              nextScreen(
                context,
                AllSuggestedUsersPage(state: state),
              );
            }
          },
          child: const Text(
            'View all',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: AppColors.blueColor),
          ),
        )
      ],
    ),
  );
}
