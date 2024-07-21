// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/data/services/shared_preference/shared_preference.dart';
import 'package:social_book/data/services/socket/socket_services.dart';
import 'package:social_book/presentation/screens/profile/edit_profile/edit_profile_sreen.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_circle_widget.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_menu.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_post_follow_count.dart';
import 'package:social_book/presentation/screens/profile/widgets/user_heading_widget.dart';
import 'package:social_book/presentation/screens/settings/settings.dart';
import 'package:social_book/presentation/screens/user_signin/user_signin_screen.dart';
import 'package:social_book/presentation/widgets/custom_outlined_button.dart';
import 'package:social_book/presentation/widgets/fadein_animate.dart';

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({
    super.key,
    required this.userModel,
    required this.postsList,
    this.onProfile = false,
    required this.isCurrentUser,
  });

  final UserModel userModel;
  final List<PostModel> postsList;
  final bool onProfile;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        UserHeadingWidget(
          isCurrentUser: isCurrentUser,
          userModel: userModel,
          onProfile: onProfile,
          onTap: () {
            debugPrint('dddd');
            FocusScope.of(context).unfocus();

            _profileMore(
              context,
            );
          },
        ),
        kHeight(10),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 40,
                      color: Colors.black.withOpacity(0.05),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ProfileCircleWidget(
                            radius: 100,
                            imageWidget: userModel.profilePicture == ""
                                ? Image.asset(profilePlaceholder)
                                : FadedImageLoading(
                                    imageUrl: userModel.profilePicture!,
                                  ),
                          ),
                          kWidth(20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userModel.fullName!,
                                style: const TextStyle(fontSize: 17),
                              ),
                              kHeight(5),
                              Text(
                                '${userModel.accountType} profile'.capitalize(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: theme.colorScheme.secondary,
                                ),
                              ),
                              kHeight(10),
                              SizedBox(
                                height: 35,
                                width: 150,
                                child: CustomOutlinedBtn(
                                  onPressed: () {
                                    nextScreen(context,
                                        EditProfileScreen(user: userModel));
                                  },
                                  btnText: 'EDIT PROFILE',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      kHeight(15),
                      userModel.bio != '' ? Text(userModel.bio!) : Container(),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -40,
                child: ProfilePostFollowCountWidget(
                  postsList: postsList,
                  userModel: userModel,
                  isCurrentUser: true,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<dynamic> _profileMore(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return ProfileMenu(
          profileImage: userModel.profilePicture!,
          leading: const [
            AppIcons.settings,
            AppIcons.about,
            AppIcons.logout_2,
          ],
          buttonLabel: const ["Settings", "About Us", "Logout"],
          ontap: [
            () {
            
              nextScreen(
                context,
                SettingsPage(accountType: userModel.accountType!),
              ).then((value) => Navigator.pop(context));
            },
            () {
            
              // nextScreen(context, const AboutUsPage())
            },
            () async {
              UserAuthStatus.saveUserStatus(false);
              SocketServices().disconnectSocket();
            
              // context.read<ChatBloc>().add(ClearAllMessageEvent());
              await nextScreenRemoveUntil(
                context,
                const UserSigninScreen(),
              );
            }
          ],
        );
      },
    );
  }
}
