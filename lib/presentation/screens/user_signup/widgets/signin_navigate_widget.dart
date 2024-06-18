import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/model/user_model/user_model.dart';
import 'package:social_book/main_screen.dart';
import 'package:social_book/presentation/bloc/user_sign_up/sign_up_bloc.dart';
import 'package:social_book/presentation/screens/user_signin/user_signin_screen.dart';
import 'package:social_book/presentation/widgets/custom_button.dart';
import 'package:social_book/presentation/widgets/custom_text_form_field.dart';

Widget signInNavigate(context) {
  return FadeInUp(
      delay: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 1000),
      child: InkWell(
        onTap: () {
          nextScreenRemoveUntil(context, const UserSigninScreen());
        },
        child: Text.rich(TextSpan(children: [
          TextSpan(
            text: "Already have an account? ",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const TextSpan(text: 'Sign In.'),
        ])),
      ));
}

Future<dynamic> validateEmail({
  BuildContext? context,
  String? email,
  String? phoneNo,
  String? fullName,
  String? password,
  String? username,
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
          title: Text(
            'Verification',
            style: TextStyle(
                fontVariations: fontWeightW600,
                color: Theme.of(context).colorScheme.primary),
          ),
          content: const Text(
              'A 6 - Digit OTP has been sent to your email address, enter it below to continue'),
          actions: [
            BlocConsumer<SignUpBloc, SignUpState>(
              listener: (context, state) {
                if (state is UserSignUpSuccessState) {
                  nextScreenRemoveUntil(context, const MainScreen());
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Form(
                        key: formKey,
                        child: CustomTextFormField(
                          hintText: 'OTP',
                          controller: otpController,
                          validator: (val) {},
                        ))
                  ],
                );
              },
            ),
            kHeight(20),
            signUpButton(formKey, otpController, username, password, email,
                fullName, phoneNo, context)
          ],
        );
      });
}

Widget signUpButton(
    GlobalKey<FormState> formKey,
    TextEditingController? otpController,
    String? username,
    String? password,
    String? email,
    String? fullName,
    String? phoneNo,
    BuildContext context) {
  return CustomButton(
    buttonText: 'Sign Up',
    onPressed: () {
      FocusScope.of(context).unfocus();
      if (formKey.currentState!.validate()) {
        final user = UserModel(
          username: username,
          password: password,
          email: email,
          fullName: fullName,
          phoneNumber: int.parse(phoneNo ?? '0'),
          otp: otpController!.text,
        );
      }
    },
  );
}
