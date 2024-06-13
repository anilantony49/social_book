import 'package:flutter/material.dart';
import 'package:social_book/bottom_nav_with_animated_icons.dart';
import 'package:social_book/core/theme/app_theme.dart';
import 'package:social_book/presentation/screens/explore/explore_screen.dart';
import 'package:social_book/presentation/screens/user_signin/user_signin_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SocialBook',
      theme: lightTheme,
      home: const UserSigninScreen(),
    );
  }
}


