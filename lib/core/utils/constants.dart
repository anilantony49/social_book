import 'package:flutter/material.dart';

const fontWeightW600 = <FontVariation>[FontVariation('wght', 600.0)];
const fontWeightW700 = <FontVariation>[FontVariation('wght', 700.0)];
const fontWeightW800 = <FontVariation>[FontVariation('wght', 800.0)];
const fontWeightRegular = <FontVariation>[FontVariation('wght', 400.0)];
const fontWeightW500 = <FontVariation>[FontVariation('wght', 500.0)];

SizedBox kWidth(double? width) => SizedBox(width: width);
SizedBox kHeight(double? height) => SizedBox(height: height);
var kBoxShadow = [
  BoxShadow(
    blurRadius: 40,
    color: Colors.black.withOpacity(0.05),
  ),
];
