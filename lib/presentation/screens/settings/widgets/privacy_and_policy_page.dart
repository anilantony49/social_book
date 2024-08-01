import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/screens/settings/utils/text_styles.dart';
import 'package:social_book/presentation/screens/settings/utils/utils.dart';
import 'package:social_book/presentation/screens/settings/widgets/settings_appbar.dart';

class PrivacyAndPolicyPage extends StatelessWidget {
  const PrivacyAndPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    // var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: SettingsAppbar(
          title: 'Privacy & Policy',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        shrinkWrap: true,
        children: [
          content(PrivacyPolicy.title),
          kHeight(20),
          heading(
            'Information We Collect',
          ),
          content(PrivacyPolicy.informationCollection),
          bulletedList([], PrivacyPolicy.infoCollectionList),
          kHeight(15),
          content(PrivacyPolicy.infoCollection3),
          kHeight(15),
          content(PrivacyPolicy.infoCollection4),
          kHeight(15),
          content(PrivacyPolicy.infoCollection5),
          kHeight(20),
          heading('Opt-Out Rights'),
          content(PrivacyPolicy.optOutRights),
          kHeight(20),
          heading('Data Retention Policy'),
          content(PrivacyPolicy.dataRetentionPolicy),
          kHeight(20),
          heading('Children'),
          content(PrivacyPolicy.children1),
          kHeight(15),
          content(PrivacyPolicy.children2),
          kHeight(20),
          heading('Security'),
          content(PrivacyPolicy.security),
          kHeight(20),
          heading('Changes'),
          content(PrivacyPolicy.changes),
          kHeight(15),
          buildSpanText2(
            PrivacyPolicy.effectiveDate,
            PrivacyPolicy.effectiveText,
          ),
          kHeight(20),
          heading('Your Consent'),
          content(PrivacyPolicy.yourConsent),
          kHeight(20),
          heading('Contact Us'),
          content(PrivacyPolicy.contactUs),
        ],
      ),
    );
  }
}
