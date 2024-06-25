import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/core/utils/validations.dart';
import 'package:social_book/presentation/screens/user_signin/widgets/sign_in_widget.dart';
import 'package:social_book/presentation/widgets/custom_button.dart';
import 'package:social_book/presentation/widgets/custom_text_form_field.dart';

class ForgetFieldWidget extends StatefulWidget {
  const ForgetFieldWidget({super.key});

  @override
  State<ForgetFieldWidget> createState() => _ForgetFieldWidgetState();
}

class _ForgetFieldWidgetState extends State<ForgetFieldWidget> {
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 1000),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 30),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kHeight(30),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Forgot your password?',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  kHeight(10),
                  const Text(
                      "Enter the email address and we'll send you a OTP to reset your password"),
                ],
              ),
              kHeight(25),
              // Username field
              CustomTextFormField(
                controller: emailController,
                hintText: 'Email address',
                validator: (value) {
                  if (!RegExp(emailRegexPattern).hasMatch(value!) ||
                      value.isEmpty) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              kHeight(25),

              // Sign in button

              CustomButton(
                buttonText: 'Send OTP',
                onPressed: () {},
              ),
              kHeight(10),
              const Spacer(),
              signUpNavigate(context)
            ],
          ),
        ),
      ),
    );
  }
}
