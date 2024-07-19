import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:social_book/core/utils/constants.dart';

class ProfileMenu extends StatelessWidget {
  final String profileImage;
  final List<void Function()?> ontap;
  final List<String> buttonLabel;
  final List<IconData> leading;
  const ProfileMenu({
    super.key,
    required this.profileImage,
    required this.ontap,
    required this.buttonLabel,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBottomBtns(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBtns(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _MenuTextBtn(
          label: buttonLabel[index],
          onTap: ontap[index],
          icon: leading[index],
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(thickness: 1, height: 1, color: Colors.white)
            .animate()
            .scale(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(microseconds: 500),
              curve: Curves.easeOutBack,
            );
      },
      itemCount: buttonLabel.length,
    );
  }
}

class _MenuTextBtn extends StatelessWidget {
  const _MenuTextBtn({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(icon, color: lWhite, size: 20),
            kWidth(10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
