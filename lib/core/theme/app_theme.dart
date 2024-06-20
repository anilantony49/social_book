import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_book/core/utils/app_colors.dart';

var mainFont = 'Coco-Gothic-Pro';

var lightTheme = ThemeData(
    fontFamily: mainFont,
    // colorScheme: const ColorScheme(
    //     brightness: Brightness.dark,
    //     primary: AppColors.lBlack,
    //     onPrimary: AppColors.lBlue,
    //     secondary: AppColors.lGray,
    //     onSecondary: AppColors.lLightGrey,
    //     error:  Colors.red,
    //     onError:  Colors.red,
    //     surface:AppColors.lLightWhite ,
    //     onSurface: AppColors.lLightGrey4)
        );

void changeSystemThemeOnPopup(
    {Color? color, required BuildContext context, Color? statusColor}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusColor ?? Colors.transparent,
      statusBarIconBrightness: Theme.of(context).colorScheme.brightness,
      statusBarBrightness: Theme.of(context).colorScheme.brightness,
      systemNavigationBarColor: color ?? const Color(0xFFb8b7bb),
    ),
  );
}