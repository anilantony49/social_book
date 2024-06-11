import 'package:flutter/material.dart';

class AppIcons {
  // Private constructor to prevent instantiation.
  AppIcons._();

  static const _kFontFam = 'Sniglet';
  static const String? _kFontPkg = null;

  static const IconData smile = Icons.sentiment_satisfied_alt; // Example icon
  static const IconData notification_bing =
      IconData(0xe847, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
