import 'package:flutter/material.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/data/services/shared_preference/shared_preference.dart';
import 'package:social_book/data/services/socket/socket_services.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_menu.dart';
import 'package:social_book/presentation/screens/user_signin/user_signin_screen.dart';
import 'package:social_book/presentation/widgets/fadein_animate.dart';
import 'package:social_book/presentation/screens/profile/edit_profile/edit_profile_sreen.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_circle_widget.dart';
import 'package:social_book/presentation/widgets/custom_button_profile.dart';

class ProfileDetailWidget extends StatelessWidget {
  final List<PostModel> postsList;
  final UserModel userModel;
  final bool isCurrentUser;
  const ProfileDetailWidget({
    super.key,
    required this.userModel,
    required this.isCurrentUser,
    required this.postsList,
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
           Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text("${postsList.length}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Text('Posts')
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
                child: VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                  width: 20,
                  indent: 10,
                  endIndent: 10,
                ),
              ),
               const Expanded(
                child: Column(
                  children: [
                    Text('870', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Following')
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
                child: VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                  width: 20,
                  indent: 10,
                  endIndent: 10,
                ),
              ),
              const Expanded(
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

  Future<dynamic> _profileMore(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return ProfileMenu(
          leading: const [
            AppIcons.settings,
            AppIcons.about,
            AppIcons.logout_2,
          ],
          buttonLabel: const ["Settings", "About Us", "Logout"],
          ontap: [
            () {
              // nextScreen(
              //   context,
              //   SettingsPage(accountType: userModel.accountType!),
              // ).then((value) => Navigator.pop(context));
            },
            () {
              // nextScreen(context, const AboutUsPage()).then(
              //   (value) => Navigator.pop(context),
              // );
            },
            () async {
              UserAuthStatus.saveUserStatus(false);
              SocketServices().disconnectSocket();

              // context.read<ChatBloc>().add(ClearAllMessageEvent());
              // await nextScreenRemoveUntil(
              //   context,
              //   const UserSigninScreen(),
              // );
            }
          ], profileImage: '',
        );
      },
    );
  }
}
