import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/widgets/custom_text_form_field.dart';

class EditFormField extends StatelessWidget {
  final TextEditingController fullnameController;
  final TextEditingController usernameController;
  final TextEditingController bioController;

  const EditFormField({
    super.key,
    required this.fullnameController,
    required this.usernameController,
    required this.bioController,
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
      ],
    );
  }

  Text textfieldHeading(String text, BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
