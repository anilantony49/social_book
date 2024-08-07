import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_book/core/theme/app_theme.dart';
import 'package:social_book/core/utils/app_colors.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    required this.searchController,
    required this.onChanged,
    this.hintText,
    required this.heading,
  });

  final TextEditingController searchController;
  final void Function(String)? onChanged;

  final String? hintText;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kHeight(20),
        Text(
          heading,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        kHeight(10),
        CupertinoSearchTextField(
          controller: searchController,
          onChanged: onChanged,
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          backgroundColor: const Color.fromARGB(255, 220, 215, 215),
          prefixInsets: const EdgeInsetsDirectional.only(start: 10),
          suffixInsets: const EdgeInsetsDirectional.only(end: 10),
          prefixIcon: const Icon(
            AppIcons.search_2,
            color: AppColors.lGray,
            size: 20,
          ),
          suffixIcon: const Icon(
            AppIcons.close,
            size: 24,
            color: AppColors.lGray,
          ),
          placeholder: hintText ?? 'Search here...',
          placeholderStyle: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: mainFont,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2,
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: mainFont,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2,
          ),
        ),
        kHeight(15),
      ],
    );
  }
}
