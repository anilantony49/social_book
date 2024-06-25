import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/core/utils/validations.dart';
import 'package:social_book/presentation/cubit/drop_down/drop_down_cubit.dart';
import 'package:social_book/presentation/screens/user_signup/user_name_create_screen.dart';
import 'package:social_book/presentation/widgets/custom_button.dart';
import 'package:social_book/presentation/widgets/custom_text_form_field.dart';

class SignupFieldWidget extends StatefulWidget {
  const SignupFieldWidget({super.key});

  @override
  State<SignupFieldWidget> createState() => _SignupFieldWidgetState();
}

class _SignupFieldWidgetState extends State<SignupFieldWidget> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create an account',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    kHeight(10),
                    const Text(
                      "Please enter you information and create your account.",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                kHeight(25),

                // Full name field
                CustomTextFormField(
                  hintText: 'Full name',
                  controller: fullnameController,
                  validator: (val) {
                    if (val!.length < 3) {
                      return 'Please enter a valid name';
                    }
                    return null;
                  },
                ),
                kHeight(20),

                // Email address field

                CustomTextFormField(
                  hintText: 'Email address',
                  controller: emailController,
                  validator: (val) {
                    if (!RegExp(emailRegexPattern).hasMatch(val!) ||
                        val.isEmpty) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                kHeight(20),

                // Phone number field
                CustomTextFormField(
                  hintText: 'Phone number',
                  controller: phoneNumberController,
                  validator: (val) {
                    if (val!.length < 10) {
                      return 'Enter a valid phone number';
                    }
                    return null;
                  },
                ),
                kHeight(20),

                // Continue button
                BlocBuilder<DropdownCubit, DropdownState>(
                  builder: (context, state) {
                    return CustomButton(
                      buttonText: 'Continue',
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState!.validate()) {
                          nextScreen(
                              context,
                              UserNameCreateScreen(
                                email: emailController.text,
                                accountType: state.name,
                                fullName: fullnameController.text,
                                phoneNo: phoneNumberController.text,
                              ));
                        }
                      },
                    );
                  },
                )
              ],
            ),
          )),
    );
  }
}
