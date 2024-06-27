import 'package:flutter/material.dart';

const fontWeightW600 = <FontVariation>[FontVariation('wght', 600.0)];

const profilePlaceholder='assets/images/profile_placeholder.jpg';


SizedBox kWidth(double? width) => SizedBox(width: width);
SizedBox kHeight(double? height) => SizedBox(height: height);

formattedTime({required int timeInSecond}) {
  int sec = timeInSecond % 60;
  int min = (timeInSecond / 60).floor();
  String minute = min.toString().length <= 1 ? "0$min" : "$min";
  String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
  return "$minute:$second";
}

var kBoxShadow = [
  BoxShadow(
    blurRadius: 40,
    color: Colors.black.withOpacity(0.05),
  ),
];

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

String filterPostTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 365) {
    final years = (difference.inDays / 365).floor();
    return '$years${years == 1 ? 'y' : 'y'}';
  } else if (difference.inDays >= 30) {
    final months = (difference.inDays / 30).floor();
    return '$months${months == 1 ? 'm' : 'm'}';
  } else if (difference.inDays >= 7) {
    final weeks = (difference.inDays / 7).floor();
    return '$weeks${weeks == 1 ? 'w' : 'w'}';
  } else if (difference.inDays > 0) {
    return '${difference.inDays}${difference.inDays == 1 ? 'd' : 'd'}';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}${difference.inHours == 1 ? 'h' : 'h'}';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}${difference.inMinutes == 1 ? 'min' : 'min'}';
  } else {
    return 'Just now';
  }
}