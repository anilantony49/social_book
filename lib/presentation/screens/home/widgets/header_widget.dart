import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_book/core/utils/app_colors.dart';
import 'package:social_book/core/utils/app_icons.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'SocialBook',
          style: GoogleFonts.sniglet(fontSize: 24),
        ),
         const Icon(
          EneftyIcons.notification_bing_outline,
          color: AppColors.blueColor
        ),
      ],
    );
  }
}
