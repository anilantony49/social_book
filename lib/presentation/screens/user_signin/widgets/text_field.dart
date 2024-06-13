import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'package:social_book/presentation/widgets/custom_button.dart';
import 'package:social_book/presentation/widgets/custom_text_form_field.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({super.key});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome back!',
                        style: TextStyle(
                            fontSize: 20, fontVariations: fontWeightW700),
                      ),
                      kHeight(10),
                      const Text(
                        "Enter your login details to continue.",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                kHeight(25),
                CustomTextFormField(
                  controller: usernameController,
                  hintText: 'Username',
                  validator: (value) {
                    if (value!.length < 4) {
                      return 'Username should not be empty';
                    }
                    return null;
                  },
                ),
                kHeight(20),

                // Password field

                CustomTextFormField(
                  hintText: 'Password',
                  suffix: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      AppIcons.eye_slash,
                      size: 20,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  validator: (value) {
                    if (value!.length < 4) {
                      return 'Password should not be empty';
                    }
                    return null;
                  },
                ),
                kHeight(25),

                // Sign in button
                CustomButton(
                  buttonText: 'Sign In',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
                kHeight(10),
                InkWell(
                  onTap: () {
                    nextScreen(context, const ForgotPasswordScreen());
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Forget Password?',
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
