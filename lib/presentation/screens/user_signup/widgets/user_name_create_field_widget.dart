import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/core/utils/validations.dart';
import 'package:social_book/presentation/bloc/user_sign_up/sign_up_bloc.dart';
import 'package:social_book/presentation/screens/user_signup/widgets/signin_navigate_widget.dart';
import 'package:social_book/presentation/widgets/custom_button.dart';
import 'package:social_book/presentation/widgets/custom_text_form_field.dart';

class UserNameCreateFieldWidget extends StatefulWidget {
  const UserNameCreateFieldWidget({
    super.key,
    required this.email,
    required this.phoneNo,
    required this.fullName,
    required this.accountType,
  });
  final String email;
  final String phoneNo;
  final String fullName;
  final String accountType;

  @override
  State<UserNameCreateFieldWidget> createState() =>
      _UserNameCreateFieldWidgetState();
}

class _UserNameCreateFieldWidgetState extends State<UserNameCreateFieldWidget> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 1000),
      child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select a Username',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                kHeight(10),
                const Text(
                  'Help secure your account',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                kHeight(20),
                // Username field
                CustomTextFormField(
                  hintText: 'Username',
                  controller: userNameController,
                  validator: (val) {
                    if (val!.length < 4) {
                      return 'Username should have at least 4 characters';
                    }
                    if (val.endsWith('.') || val.endsWith('_')) {
                      return "Username can't end with period or underscore";
                    }
                    if (!RegExp(
                            r"^(?=.{4,20}$)(?![_.])[a-zA-Z0-9._]+(?<![_.])$")
                        .hasMatch(val)) {
                      return 'Username can only user letters, numbers, underscores and periods';
                    }
                    return null;
                  },
                ),

                // Create password field
                kHeight(20),
                BlocBuilder<PasswordVisibilityCubit, bool>(
                  builder: (context, state) {
                    return CustomTextFormField(
                      hintText: 'Create password',
                      controller: passWordController,
                      validator: (val) {
                        if (!RegExp(passowrdRegexPattern).hasMatch(val!)) {
                          return 'Passwords should be 8 characters, at least one number and one special character';
                        }
                        return null;
                      },
                      obscureText: state,
                      suffix: GestureDetector(
                        onTap: () {
                          context
                              .read<PasswordVisibilityCubit>()
                              .toggleVisibility();
                        },
                        child: Icon(
                          state ? AppIcons.eyeslash : AppIcons.eye,
                          size: 20,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    );
                  },
                ),
                kHeight(20),
                BlocBuilder<PasswordVisibilityCubit, bool>(
                  builder: (context, state) {
                    return CustomTextFormField(
                      hintText: 'Confirm password',
                      controller: confirmPasswordController,
                      validator: (val) {
                        if (!RegExp(passowrdRegexPattern).hasMatch(val!)) {
                          return 'Passwords should be 8 characters, at least one number and one special character';
                        }
                        return null;
                      },
                      obscureText: state,
                      suffix: GestureDetector(
                        onTap: () {
                          context
                              .read<PasswordVisibilityCubit>()
                              .toggleVisibility();
                        },
                        child: Icon(
                          state ? AppIcons.eyeslash : AppIcons.eye,
                          size: 20,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    );
                  },
                ),
                kHeight(25),
                // Sign Up button
                BlocListener<SignUpBloc, SignUpState>(
                  listener: signUpListener,
                  child: CustomButton(
                    buttonText: 'Sign Up',
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (passWordController.text ==
                          confirmPasswordController.text) {
                        if (formKey.currentState!.validate()) {
                          context.read<SignUpBloc>().add(
                              UserOtpVerificationEvent(email: widget.email));
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

  void signUpListener(BuildContext context, SignUpState state) {
    if (state is UserOtpSuccessState) {
      // nextScreen(context, const OtpScreen());
      validateEmail(
          context: context,
          fullName: widget.fullName,
          email: widget.email,
          phoneNo: widget.phoneNo,
          accountType: widget.accountType,
          otpController: otpController,
          username: userNameController.text,
          password: passWordController.text);
    }
  }
}

class PasswordVisibilityCubit extends Cubit<bool> {
  PasswordVisibilityCubit() : super(true);

  void toggleVisibility() => emit(!state);

  void reset() => emit(true);
}
