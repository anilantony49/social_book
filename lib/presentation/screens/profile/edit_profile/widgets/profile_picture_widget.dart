import 'package:flutter/material.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       
      },
      child: CircleAvatar(
        radius: 80,
        backgroundColor:Theme.of(context).colorScheme.primaryContainer ,
      ),
    );
  }
}