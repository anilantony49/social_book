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
