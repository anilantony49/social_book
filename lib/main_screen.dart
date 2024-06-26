import 'package:flutter/material.dart';
import 'package:social_book/bottom_navigation.dart';
import 'package:social_book/presentation/screens/message/message_screen.dart';
import 'package:social_book/presentation/screens/explore/explore_screen.dart';
import 'package:social_book/presentation/screens/home/home_screen.dart';
import 'package:social_book/presentation/screens/post/create_post/create_post.dart';
import 'package:social_book/presentation/screens/profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pages = [];
  @override
  void initState() {
    pages = const [
      HomeScreen(),
      ExploreScreen(),
      CreatePostScreen(),
      MessageScreen(),
      ProfileScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int index, child) {
            return IndexedStack(
              index: index,
              children: pages,
            );
          }),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
