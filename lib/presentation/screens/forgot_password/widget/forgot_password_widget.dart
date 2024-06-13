import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/widgets/custom_text_form_field.dart';

class ForgotPasswordWidget {
  static Future<dynamic> validateEmail({
    BuildContext? context,
    TextEditingController? otpController,
  }) {
    final GlobalKey<FormState> formKey = GlobalKey();
    return showDialog(
        context: context!,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(
              'Verification',
              style: TextStyle(
                fontVariations: fontWeightW600,
              ),
            ),
            content: const Text(
                'A 6 - Digit OTP has been sent to your email address, enter it below to continue'),
                 actions: [
            Column(
              children: [
                Form(
                  key: formKey,
                  child: CustomTextFormField(
                    hintText: 'OTP',
                    controller: otpController,
                    validator: (val) {
                      if (val!.length < 2) {
                        return "Please enter a valid OTP";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            kHeight(20),
            // verifyOtp(formKey, otpController, context),
          ],
          );
        });
  }
}
