import 'package:flutter/material.dart';
import 'package:hidable/hidable.dart';
import 'package:social_book/presentation/screens/explore/widget/custom_search_field.dart';
import 'package:social_book/presentation/screens/explore/widget/explore_post.dart';
import 'package:social_book/presentation/screens/explore/widget/suggested_people.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Hidable(
        controller: scrollController,
        preferredWidgetSize: const Size.fromHeight(120),
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CustomSearchField(
            heading: 'Explore',
            searchController: searchController,
          ),
        ),
      ),
      body: ListView(
        children: const [
          SuggestedPeople(),
          ExplorePost(),
        ],
      ),
    );
  }
}
