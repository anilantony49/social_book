import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/presentation/screens/user_signup_screen/user_signup_screen.dart';

Widget signUpNavigate(context) {
  return InkWell(
    onTap: () => nextScreen(context, const UserSignupScreen()),
    child: FadeInUp(
      delay: const Duration(milliseconds: 700),
      duration: const Duration(milliseconds: 1000),
      child: const Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text: "Don't have an account? ",
              style: TextStyle(
                color: Colors.grey
              ),
            ),
            TextSpan(
              text: 'Sign Up.',
            ),
          ],
        ),
      ),
    ),
  );
}
