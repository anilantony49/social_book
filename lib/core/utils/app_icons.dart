import 'package:flutter/material.dart';

class AppIcons {
  // Private constructor to prevent instantiation.
  AppIcons._();

  static const _kFontFam = 'AppIcon';
  static const String? _kFontPkg = null;

  static const IconData smile = Icons.sentiment_satisfied_alt; // Example icon
  static const IconData notification_bing =
      IconData(0xe847, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData search_2 =
      IconData(0xe854, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData close =
      IconData(0xe81c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
