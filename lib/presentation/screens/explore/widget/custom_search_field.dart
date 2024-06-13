import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_book/core/theme/app_theme.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    required this.searchController,
    // required this.onChanged,
    this.hintText,
  });

  final TextEditingController searchController;
  // final void Function(String)? onChanged;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        kHeight(15),
        const Text(
          'Explore',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        kHeight(10),
        CupertinoSearchTextField(
          controller: searchController,
          // onChanged: onChanged,
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          backgroundColor: const Color.fromARGB(255, 220, 215, 215),
          prefixInsets: const EdgeInsetsDirectional.only(start: 10),
          suffixInsets: const EdgeInsetsDirectional.only(end: 10),
          prefixIcon: Icon(
            AppIcons.search_2,
            color: theme.colorScheme.primary,
            size: 20,
          ),
          suffixIcon: Icon(
            AppIcons.close,
            size: 24,
            color: theme.colorScheme.secondary,
          ),
          placeholder: hintText ?? 'Search here...',
          placeholderStyle: TextStyle(
            color: theme.colorScheme.secondary,
            fontSize: 14,
            fontFamily: mainFont,
            fontVariations: fontWeightRegular,
            letterSpacing: 0.2,
          ),
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontSize: 14,
            fontFamily: mainFont,
            fontVariations: fontWeightRegular,
            letterSpacing: 0.2,
          ),
        ),
        kHeight(15),
      ],
    );
  }
}
