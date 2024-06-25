import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_book/core/utils/app_colors.dart';

Future<dynamic> nextScreen(context, page) {
  return Navigator.push(
    context,
    PageTransition(
      child: page,
      type: PageTransitionType.fade,
    ),
  );
}

Future<dynamic> nextScreenRemoveUntil(context, page) {
  return Navigator.pushAndRemoveUntil(
    context,
    PageTransition(
      child: page,
      type: PageTransitionType.fade,
    ),
    (route) => false,
  );
}

void customSnackbar(
  BuildContext context,
  String message,
) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      backgroundColor: AppColors.dLightBlueGrey2,
      dismissDirection: DismissDirection.up,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      )));
}
