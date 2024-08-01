import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/screens/settings/utils/text_styles.dart';
import 'package:social_book/presentation/screens/settings/utils/utils.dart';
import 'package:social_book/presentation/screens/settings/widgets/settings_appbar.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: SettingsAppbar(
          title: 'Terms & Conditions',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        shrinkWrap: true,
        children: [
          content(PrivacyPolicy.title),
          kHeight(15),
          content(TermsAndconditions.term1),
          kHeight(15),
          content(TermsAndconditions.term2),
          kHeight(15),
          content(TermsAndconditions.term3),
          kHeight(15),
          content(TermsAndconditions.term4),
          kHeight(15),
          content(TermsAndconditions.term5),
          kHeight(15),
          content(TermsAndconditions.term6),
          kHeight(15),
          content(TermsAndconditions.term7),
          kHeight(15),
          content(TermsAndconditions.term8),
          kHeight(20),
          heading('Changes to these Terms and Conditions'),
          content(TermsAndconditions.changesToTerms),
          kHeight(15),
          buildSpanText2(
            TermsAndconditions.effectiveDate,
            TermsAndconditions.effectiveText,
          ),
          kHeight(20),
          heading('Contact Us'),
          content(TermsAndconditions.contactUs),
        ],
      ),
    );
  }
}
