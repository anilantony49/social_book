import 'package:flutter/material.dart';
import 'package:social_book/bottom_nav_with_animated_icons.dart';
import 'package:social_book/bottom_navigation.dart';
import 'package:social_book/home/home_screen.dart';
import 'package:social_book/splash_screen.dart';

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
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 231, 229, 229),
          primarySwatch: Colors.blue,
          //  fontFamily: "Intel",
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            // fillColor: Colors.white,
            // errorStyle: TextStyle(height: 0),
            // border: defaultInputBorder,
            // enabledBorder: defaultInputBorder,
            // focusedBorder: defaultInputBorder,
            // errorBorder: defaultInputBorder,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const BottomNavWithAnimatedIcons());
  }
}

const defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    borderSide: BorderSide(color: Color(0xFFDEE3F2), width: 1));
