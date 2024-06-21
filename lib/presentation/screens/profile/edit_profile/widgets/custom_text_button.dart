import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onTap;
  final String buttonText;
  const CustomTextButton({
    super.key,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Text(
          buttonText,
          style: TextStyle(
            fontVariations: fontWeightW500,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
