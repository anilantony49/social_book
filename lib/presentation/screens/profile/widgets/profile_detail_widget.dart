import 'package:flutter/material.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/model/user_model/user_model.dart';
import 'package:social_book/presentation/screens/explore/widget/fadein_animate.dart';
import 'package:social_book/presentation/screens/profile/edit_profile/edit_profile_sreen.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_circle_widget.dart';
import 'package:social_book/presentation/widgets/custom_button_profile.dart';

class ProfileDetailWidget extends StatelessWidget {
  final UserModel userModel;
  final bool isCurrentUser;
  const ProfileDetailWidget({
    super.key,
    required this.userModel,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 10, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileCircleWidget(
            // backgroundImage: AssetImage('assets/images/myself.jpg'),
            // backgroundColor: Colors.grey,
            radius: 80,
            imageWidget: userModel.profilePicture == ""
                ? Image.asset(
                    profilePlaceholder,
                  )
                : FadedImageLoading(
                    imageUrl: userModel.profilePicture!,
                  ),
          ),
          kHeight(10),
          Text(
            userModel.fullName!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          kHeight(10),
          userModel.bio != '' ? Text(userModel.bio!) : Container(),
          kHeight(10),
          CustomButtonProfile(
            buttonText: 'Edit profile',
            onPressed: () {
              FocusScope.of(context).unfocus();
              nextScreen(context, EditProfileScreen(user: userModel));
            },
          ),
          kHeight(10),
          const Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text('87', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Posts')
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                  width: 20,
                  indent: 10,
                  endIndent: 10,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('870', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Following')
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                  width: 20,
                  indent: 10,
                  endIndent: 10,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '15K',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Followers')
                  ],
                ),
              ),
            ],
          ),
          //  kHeight(50),
        ],
      ),
    );
  }
}
