import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_colors.dart';

class CustomButtonProfile extends StatelessWidget {
  const CustomButtonProfile(
      {super.key, required this.buttonText, this.onPressed});

  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 390,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      
        color: AppColors.customBtnColor,
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }
}
