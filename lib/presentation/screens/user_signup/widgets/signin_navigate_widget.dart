import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/presentation/screens/user_signin/user_signin_screen.dart';

Widget signInNavigate(context) {
  return FadeInUp(
      delay: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 1000),
      child: InkWell(
        onTap: () {
          nextScreenRemoveUntil(context, const UserSigninScreen());
        },
        child: Text.rich(
          TextSpan(
            children: [
                TextSpan(
                text: "Already have an account? ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const TextSpan(text: 'Sign In.'),
            ]
          )
          ),
      ));
}
