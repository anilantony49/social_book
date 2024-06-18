import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/bottom_navigation.dart';
import 'package:social_book/core/theme/app_theme.dart';
import 'package:social_book/main_screen.dart';
import 'package:social_book/presentation/bloc/user_sign_up/sign_up_bloc.dart';
import 'package:social_book/presentation/screens/explore/explore_screen.dart';
import 'package:social_book/presentation/screens/user_signin/user_signin_screen.dart';
import 'package:social_book/presentation/screens/user_signup/user_signup_screen.dart';
import 'package:social_book/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>SignUpBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SocialBook',
        theme: lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
