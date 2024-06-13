import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/core/utils/validations.dart';
import 'package:social_book/presentation/widgets/custom_button.dart';
import 'package:social_book/presentation/widgets/custom_text_form_field.dart';

class ResetFieldWidget extends StatefulWidget {
  const ResetFieldWidget({super.key, required this.email});

   final String email;

  @override
  State<ResetFieldWidget> createState() => _ResetFieldWidgetState();
}

class _ResetFieldWidgetState extends State<ResetFieldWidget> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 600),
      duration: const Duration(milliseconds: 1000),
      child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // New Password
                CustomTextFormField(
                  hintText: 'New Password',
                  controller: newPasswordController,
                  validator: (val) {
                    if (!RegExp(passowrdRegexPattern).hasMatch(val!) ||
                        val.isEmpty) {
                      return 'Passwords should be 8 characters, at least one number and one special character';
                    }
                    return null;
                  },
                ),
                kHeight(20),
                // Confirm Password
                CustomTextFormField(
                  hintText: 'Confirm Password',
                  controller: confirmPasswordController,
                  validator: (val) {
                    if (!RegExp(passowrdRegexPattern).hasMatch(val!) ||
                        val.isEmpty) {
                      return 'Passwords should be 8 characters, at least one number and one special character';
                    }
                    return null;
                  },
                ),
                kHeight(20),

                // Confirm Button
                CustomButton(buttonText: 'Next',
                onPressed: (){

                },)
              ],
            ),
          )),
    );
  }
}
