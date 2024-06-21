import 'package:flutter/material.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/screens/profile/edit_profile/widgets/edit_form_field.dart';
import 'package:social_book/presentation/screens/profile/edit_profile/widgets/edit_profile_appbar.dart';
import 'package:social_book/presentation/screens/profile/edit_profile/widgets/profile_picture_widget.dart';

class EditProfileSreen extends StatefulWidget {
  const EditProfileSreen({super.key});

  @override
  State<EditProfileSreen> createState() => _EditProfileSreenState();
}

class _EditProfileSreenState extends State<EditProfileSreen> {
  final fullnameController = TextEditingController();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();
  final emailController = TextEditingController();
  final phonenumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: EditProfileAppbar(
            fullnameController: fullnameController,
            usernameController: usernameController,
            bioController: bioController,
          )),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        children: [
          const ProfilePictureWidget(),
          kHeight(30),
          EditFormField(
            fullnameController: fullnameController,
            usernameController: usernameController,
            bioController: bioController,
            emailController: emailController,
            phonenumberController: phonenumberController,
          )
        ],
      ),
    );
  }
}
