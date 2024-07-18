import 'package:flutter/material.dart';
import 'package:social_book/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:social_book/presentation/screens/explore/widget/suggested_people.dart';
import 'package:social_book/presentation/screens/explore/widget/suggested_people_grid_view.dart';
import 'package:social_book/presentation/widgets/custom_appbar.dart';

class AllSuggestedUsersPage extends StatelessWidget {
  const AllSuggestedUsersPage({
    super.key,
    required this.state,
  });

  final UserDetailFetchingSuccessState state;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: CustomAppbar(
          backgroundColor: theme.colorScheme.surface,
          title: 'Suggested for you',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SuggestedPeopleGridView(
        state: state,
        isDetail: true,
        reverse: false,
      ),
    );
  }
}
