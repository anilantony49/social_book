import 'package:flutter/material.dart';

class PostMoreBottomSheet extends StatefulWidget {
  const PostMoreBottomSheet({super.key});

  @override
  State<PostMoreBottomSheet> createState() => _PostMoreBottomSheetState();
}

class _PostMoreBottomSheetState extends State<PostMoreBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.all(20),
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      
    );
  }
}
