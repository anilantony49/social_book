import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Future<dynamic> nextScreen(context, page) {
  return Navigator.push(
    context,
    PageTransition(
      child: page,
      type: PageTransitionType.fade,
    ),
  );
}
