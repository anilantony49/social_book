import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/screens/settings/utils/text_styles.dart';
import 'package:social_book/presentation/screens/settings/utils/utils.dart';
import 'package:social_book/presentation/screens/settings/widgets/settings_appbar.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: SettingsAppbar(
          title: 'About Us',
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
        children: [
          _heading(context),
          content(AboutUs.about),
          kHeight(15),
          content(AboutUs.stayTuned),
          kHeight(20),
          _heading2('Our Services:'),
          bulletedList(AboutUs.featureTitle, AboutUs.features),
          kHeight(20),
          content(AboutUs.whyChoose),
          kHeight(20),
          _heading2('Our Vision:'),
          kHeight(5),
          content(AboutUs.ourVision),
        ],
      ),
    );
  }

  Text _heading2(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontVariations: fontWeightW600,
      ),
    );
  }

  Text _heading(BuildContext context) {
    return const Text(
      'Welcome to Social Book,',
      style: TextStyle(
        fontSize: 22,
        fontVariations: fontWeightW600,
        height: 2,
        color: Colors.black,
      ),
    );
  }
}
