import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidable/hidable.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
import 'package:social_book/presentation/screens/main/bottom_navigation.dart';
import 'package:social_book/data/services/search_debouncer/debouncer.dart';
import 'package:social_book/presentation/bloc/search_user/search_user_bloc.dart';
import 'package:social_book/presentation/cubit/search/search_cubit.dart';
import 'package:social_book/presentation/screens/explore/widget/custom_search_field.dart';
import 'package:social_book/presentation/screens/explore/widget/explore_post.dart';
import 'package:social_book/presentation/screens/explore/widget/suggested_people.dart';
import 'package:social_book/presentation/screens/explore/widget/user_search_result_view.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final Debouncer debouncer =
      Debouncer(delay: const Duration(milliseconds: 300));
  bool isSearchResult = false;

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Colors.white,
      child: Scaffold(
        appBar: Hidable(
          controller: scrollController,
          preferredWidgetSize: const Size.fromHeight(120),
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: CustomSearchField(
              heading: 'Explore',
              searchController: searchController,
              onChanged: (value) {
                  if (value.isNotEmpty) {
                    debouncer.run(() {
                      context
                          .read<SearchUserBloc>()
                          .add(SearchUserEvent(query: value));
                    });
                    context.read<OnSearchCubit>().onSearchChange(true);
                  } else {
                    context.read<OnSearchCubit>().onSearchChange(false);
                  }
                },
              ),
            ),
          ),
          body: MultiBlocBuilder(
            blocs: [
              context.watch<OnSearchCubit>(),
              context.watch<SearchUserBloc>()
            ],
            builder: (context, state) {
              var state1 = state[0];
              var state2 = state[1];
      
              if (state1 == false) {
                return ListView(
                  controller: explorePageController,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  children: const [
                    SuggestedPeople(),
                    ExplorePost(),
                  ],
                );
              } else {
                if (state2 is SearchResultLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2,
                    ),
                  );
                }
      
                if (state2 is SearchResultSuccessState) {
                  return UserSearchResultView(state2: state2);
                }
      
                return const Center(
                  child: Text('User Not Found!'),
                );
              }
            },
          ),
      ),
    );
  }
}
