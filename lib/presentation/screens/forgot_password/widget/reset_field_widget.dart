import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/core/utils/validations.dart';
import 'package:social_book/presentation/bloc/forget_password/forget_password_bloc.dart';
import 'package:social_book/presentation/screens/user_signin/user_signin_screen.dart';
import 'package:social_book/presentation/screens/user_signup/widgets/user_name_create_field_widget.dart';
import 'package:social_book/presentation/widgets/custom_button.dart';
import 'package:social_book/presentation/widgets/custom_text_form_field.dart';

class ResetFieldWidget extends StatefulWidget {
  const ResetFieldWidget({super.key, required this.email});

  final String email;

  @override
  State<ResetFieldWidget> createState() => _ResetFieldWidgetState();
}

class _ResetFieldWidgetState extends State<ResetFieldWidget> {
  final TextEditingController otpController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 400),
      child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Enter the OTP that we have sent to your Email",
                  style: TextStyle(fontSize: 15),
                ),
                kHeight(20),
                // OTP field
                CustomTextFormField(
                  hintText: 'Enter the 6-Digit OTP',
                  controller: otpController,
                  validator: (val) {
                    if (val!.length < 6) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                kHeight(20),
                // New Password
                BlocBuilder<PasswordVisibilityCubit, bool>(
                  builder: (context, state) {
                    return CustomTextFormField(
                      hintText: 'New Password',
                      controller: newPasswordController,
                      suffix: GestureDetector(
                        onTap: () {
                          context
                              .read<PasswordVisibilityCubit>()
                              .toggleVisibility();
                        },
                        child: Icon(state ? AppIcons.eyeslash : AppIcons.eye,
                            size: 20, color: Colors.grey),
                      ),
                      obscureText: state,
                      validator: (val) {
                        if (!RegExp(passowrdRegexPattern).hasMatch(val!) ||
                            val.isEmpty) {
                          return 'Passwords should be 8 characters, at least one number and one special character';
                        }
                        return null;
                      },
                    );
                  },
                ),
                kHeight(20),
                // Confirm Password
                BlocBuilder<PasswordVisibilityCubit, bool>(
                  builder: (context, state) {
                    return CustomTextFormField(
                      hintText: 'Confirm Password',
                      controller: confirmPasswordController,
                      suffix: GestureDetector(
                        onTap: () {
                          context
                              .read<PasswordVisibilityCubit>()
                              .toggleVisibility();
                        },
                        child: Icon(state ? AppIcons.eyeslash : AppIcons.eye,
                            size: 20, color: Colors.grey),
                      ),
                      obscureText: state,
                      validator: (val) {
                        if (!RegExp(passowrdRegexPattern).hasMatch(val!) ||
                            val.isEmpty) {
                          return 'Passwords should be 8 characters, at least one number and one special character';
                        }
                        return null;
                      },
                    );
                  },
                ),
                kHeight(20),

                // Confirm Button
                BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
                  listener: resetPasswordListener,
                  child: CustomButton(
                    buttonText: 'Save Changes',
                    onPressed: () {
                      if (newPasswordController.text ==
                          confirmPasswordController.text) {
                        if (formKey.currentState!.validate()) {
                          context.read<ForgetPasswordBloc>().add(
                                ForgetResetPasswordEvent(
                                  email: widget.email,
                                  otp: otpController.text,
                                  password: newPasswordController.text,
                                ),
                              );
                        }
                      } else {
                        customSnackbar(
                          context,
                          "Passwords doesn't match",
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }

  void resetPasswordListener(BuildContext context, ForgetPasswordState state) {
    if (state is ForgetResetPasswordSuccessState) {
      nextScreenRemoveUntil(context, const UserSigninScreen());
      customSnackbar(
        context,
        'Password changed successfully',
      );
    }
    if (state is ForgetResetPasswordInvalidOtpState) {
      customSnackbar(
        context,
        'Entered OTP is invalid',
      );
    }
  }
}
