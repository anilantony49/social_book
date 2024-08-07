import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_book/core/utils/app_colors.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/presentation/bloc/user_by_id/user_by_id_bloc.dart';

class FollowersAppbar extends StatelessWidget {
  const FollowersAppbar({
    super.key,
    required this.searchController,
    required this.onChanged,
    required this.tabController,
    required this.userId,
  });

  final TextEditingController searchController;
  final void Function(String)? onChanged;
  final TabController tabController;
  final String userId;

  @override
  Widget build(BuildContext context) {
    // var theme = Theme.of(context);
    return AppBar(
      title: const Text(
        'Connections',
        style: TextStyle(fontSize: 20),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          context.read<UserByIdBloc>().add(FetchUserByIdEvent(userId: userId));
          Navigator.pop(context);
        },
        icon: const Icon(
          AppIcons.arrow_left,
          size: 25,
        ),
      ),
      actions: [
        AnimatedSearchBar(
          searchController: searchController,
          onChanged: onChanged,
        ),
      ],
      bottom: TabBar(
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: UnderlineTabIndicator(
          borderSide: const BorderSide(width: 2, color: AppColors.blueColor),
          insets: const EdgeInsets.symmetric(horizontal: 16.0),
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorPadding: const EdgeInsets.all(0),
        splashFactory: NoSplash.splashFactory,
        dividerColor: Colors.grey,
        labelColor: Colors.blue,
        labelPadding: const EdgeInsets.all(0),
        unselectedLabelColor: Colors.grey,
        labelStyle: const TextStyle(
          // fontFamily: mainFont,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        tabs: const [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Tab(text: 'FOLLOWERS', height: 25),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Tab(text: 'FOLLOWING', height: 25),
          ),
        ],
      ),
    );
  }
}

class AnimatedSearchBar extends StatefulWidget {
  const AnimatedSearchBar({
    super.key,
    required this.searchController,
    required this.onChanged,
  });

  final TextEditingController searchController;
  final void Function(String)? onChanged;

  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  bool _isSearchActive = false;
  final _focusNode = FocusNode();

  void _toggleSearch() {
    setState(() {
      _isSearchActive = !_isSearchActive;
    });
    if (!_isSearchActive) {
      widget.searchController.clear();
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: _toggleSearch,
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInQuad,
            width:
                _isSearchActive ? MediaQuery.of(context).size.width - 100 : 40,
            height: 40,
            child: _isSearchActive
                ? Expanded(
                    child: TextField(
                      controller: widget.searchController,
                      textAlign: TextAlign.start,
                      autofocus: true,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 10),
                        border: InputBorder.none,
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: theme.colorScheme.secondary,
                          fontSize: 16,
                        ),
                      ),
                      onChanged: widget.onChanged,
                    ),
                  )
                : Container(),
          ),
          _isSearchActive
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    AppIcons.close,
                    color: theme.colorScheme.secondary,
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(AppIcons.search_2),
                ),
        ],
      ),
    );
  }
}
     