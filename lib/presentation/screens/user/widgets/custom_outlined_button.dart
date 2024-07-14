import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.btnText,
  });

  final void Function()? onPressed;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: theme.colorScheme.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        backgroundColor: AppColors.customBtnColor,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      onPressed: onPressed,
      child: Text(
        btnText,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }
}
