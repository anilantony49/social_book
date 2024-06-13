import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor2,
      extendBodyBehindAppBar: true,
      // appBar: CustomAppbar.show(context, true),
    );
  }
}
