import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/core/utils/validations.dart';
import 'package:social_book/presentation/widgets/custom_button.dart';
import 'package:social_book/presentation/widgets/custom_text_form_field.dart';

class UserNameCreateFieldWidget extends StatefulWidget {
  const UserNameCreateFieldWidget(
      {super.key,
      required this.email,
      required this.phoneNo,
      required this.fullName});
  final String email;
  final String phoneNo;
  final String fullName;

  @override
  State<UserNameCreateFieldWidget> createState() =>
      _UserNameCreateFieldWidgetState();
}

class _UserNameCreateFieldWidgetState extends State<UserNameCreateFieldWidget> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                CustomTextFormField(
                  hintText: 'Create password',
                  controller: passWordController,
                  validator: (val) {
                    if (!RegExp(passowrdRegexPattern).hasMatch(val!)) {
                      return 'Passwords should be 8 characters, at least one number and one special character';
                    }
                    return null;
                  },
                  suffix: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      AppIcons.eye_slash,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                 kHeight(25),
                 CustomButton(buttonText: 'Sign Up',
                 onPressed: (){
                  
                 },)
              ],
            ),
          )),
    );
  }
}
