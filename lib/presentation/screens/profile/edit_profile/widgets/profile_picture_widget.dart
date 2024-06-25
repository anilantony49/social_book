import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/cubit/set_profile_image/cubit/set_profile_image_cubit.dart';
import 'package:social_book/presentation/screens/profile/edit_profile/edit_profile_sreen.dart';
import 'package:social_book/presentation/widgets/media_picker_page.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ProfilePictureWidget extends StatelessWidget {
  final EditProfileScreen widget;
  const ProfilePictureWidget({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(
          context,
          const MediaPicker(
            maxCount: 1,
            requestType: RequestType.image,
            screenType: ScreenType.profile,
          ),
        );
      },
      child: CircleAvatar(
        radius: 80,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: BlocBuilder<SetProfileImageCubit, SetProfileImageState>(
          builder: (context, state) {
            if (state is SetProfileImageSuccessState) {
              return CircleAvatar(
                radius: 63,
                backgroundImage: AssetEntityImage(state.selectedImage[0]).image,
              );
            }
            return CircleAvatar(
              radius: 63,
              backgroundImage: widget.user.profilePicture == ""
                  ? Image.asset(profilePlaceholder).image
                  : NetworkImage(widget.user.profilePicture!),
            );
          },
        ),
      ),
    );
  }
}
