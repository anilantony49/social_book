import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.buttonText, this.onPressed});

  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        color: AppColors.blackColor,
        onPressed: onPressed,
        child: FadeInUp(
            child: Text(
          buttonText,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        )),
      ),
    );
  }
}
