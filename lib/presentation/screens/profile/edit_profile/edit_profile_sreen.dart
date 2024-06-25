import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/model/user_model/user_model.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/bloc/profile_logics/profile_logics_bloc.dart';
import 'package:social_book/presentation/cubit/set_profile_image/cubit/set_profile_image_cubit.dart';
import 'package:social_book/presentation/screens/profile/edit_profile/widgets/edit_form_field.dart';
import 'package:social_book/presentation/screens/profile/edit_profile/widgets/edit_profile_appbar.dart';
import 'package:social_book/presentation/screens/profile/edit_profile/widgets/profile_picture_widget.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;
  const EditProfileScreen({
    super.key,
    required this.user,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final fullnameController = TextEditingController();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void initState() {
    fullnameController.text = widget.user.fullName!;
    usernameController.text = widget.user.username!;
    bioController.text = widget.user.bio!;
    // emailController.text = widget.user.email!;
    // phonenumberController.text = widget.user.phoneNumber.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: EditProfileAppbar(
            fullnameController: fullnameController,
            usernameController: usernameController,
            bioController: bioController,
            widget: widget,
          )),
      body: BlocListener<ProfileLogicsBloc, ProfileLogicsState>(
        listener: (context, state) {
          if (state is EditUsernameAlreadyExistsState) {
            customSnackbar(
              context,
              'Username already taken',
            );
          }
          if (state is EditUserDetailsSuccessState) {
            Navigator.pop(context);
            customSnackbar(
              context,
              'Profile Details Updated',
            );
            context.read<ProfileBloc>().add(ProfileInitialFetchEvent());
            context.read<SetProfileImageCubit>().resetState();
          }
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          children: [
            ProfilePictureWidget(widget: widget),
            kHeight(30),
            EditFormField(
              fullnameController: fullnameController,
              usernameController: usernameController,
              bioController: bioController,
            )
          ],
        ),
      ),
    );
  }
}
