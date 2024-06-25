import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/data/model/user_model/user_model.dart';
import 'package:social_book/presentation/bloc/profile_logics/profile_logics_bloc.dart';
import 'package:social_book/presentation/cubit/set_profile_image/cubit/set_profile_image_cubit.dart';
import 'package:social_book/presentation/screens/profile/edit_profile/edit_profile_sreen.dart';
import 'package:social_book/presentation/screens/profile/edit_profile/widgets/custom_text_button.dart';

class EditProfileAppbar extends StatefulWidget {
  final TextEditingController fullnameController;
  final TextEditingController usernameController;
  final TextEditingController bioController;
  final EditProfileScreen widget;

  const EditProfileAppbar({
    super.key,
    required this.fullnameController,
    required this.usernameController,
    required this.bioController,
    required this.widget,
  });

  @override
  State<EditProfileAppbar> createState() => _EditProfileAppbarState();
}

class _EditProfileAppbarState extends State<EditProfileAppbar> {
  List<AssetEntity> selectedImage = [];
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Edit profile',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
          context.read<SetProfileImageCubit>().resetState();
        },
        icon: const Icon(AppIcons.arrowleftios),
      ),
      actions: [
        MultiBlocBuilder(
          blocs: [
            context.watch<SetProfileImageCubit>(),
            context.watch<ProfileLogicsBloc>(),
          ],
          builder: (context, state) {
            var state1 = state[0];
            var state2 = state[1];
            if (state1 is SetProfileImageSuccessState) {
              selectedImage = state1.selectedImage;
            }
            if (state2 is EditUserDetailsLoadingState) {
              return Container(
                height: 15,
                width: 15,
                margin: const EdgeInsets.only(right: 15),
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                  strokeWidth: 2,
                ),
              );
            }
            return CustomTextButton(
                onTap: () async {
                  if (_canSaveChanges()) {
                    UserModel updatedUser = UserModel(
                      fullName: widget.fullnameController.text,
                      username: widget.usernameController.text,
                      bio: widget.bioController.text,
                      profilePicture: widget.widget.user.profilePicture,
                    );
                    context.read<ProfileLogicsBloc>().add(EditUserDetailEvent(
                        updatedUser: updatedUser,
                        intialUser: widget.widget.user,
                        profilePicture: selectedImage));
                  } else {
                    debugPrint('Nothing to change');
                  }
                },
                buttonText: 'SAVE');
          },
        )

      ],
        
    );
  }

  bool _canSaveChanges() {
    final fullname = widget.fullnameController.text;
    final username = widget.usernameController.text;
    final bio = widget.bioController.text;
    final user = widget.widget.user;

    return fullname != user.fullName ||
        username != user.username ||
        bio != user.bio ||
        selectedImage.isNotEmpty;
  }
}
