import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/widgets/custom_text_form_field.dart';

class EditFormField extends StatelessWidget {
  final TextEditingController fullnameController;
  final TextEditingController usernameController;
  final TextEditingController bioController;
  final TextEditingController emailController;
  final TextEditingController phonenumberController;
  const EditFormField({
    super.key,
    required this.fullnameController,
    required this.usernameController,
    required this.bioController,
    required this.emailController,
    required this.phonenumberController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textfieldHeading('Full name:', context),
        kHeight(6),
        CustomTextFormField(
          controller: fullnameController,
          hintText: 'Fullname',
        ),
        kHeight(20),
        textfieldHeading('Username:', context),
        kHeight(6),
        CustomTextFormField(
          controller: usernameController,
          hintText: 'Username',
        ),
        kHeight(20),
        textfieldHeading('Bio:', context),
        kHeight(6),
        CustomTextFormField(
          controller: bioController,
          hintText: 'Bio',
        ),
        kHeight(20),
        textfieldHeading('Email address:', context),
        kHeight(6),
        CustomTextFormField(
          readOnly: true,
          controller: emailController,
          hintText: 'Email address',
        ),
        kHeight(20),
        textfieldHeading('Phone number:', context),
        kHeight(6),
        CustomTextFormField(
          readOnly: true,
          controller: phonenumberController,
          hintText: 'Phone number',
        ),
      ],
    );
  }

  Text textfieldHeading(String text, BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontVariations: fontWeightW600,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
