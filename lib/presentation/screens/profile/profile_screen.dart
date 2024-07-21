import 'dart:developer';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/bottom_navigation.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/services/shared_preference/shared_preference.dart';
import 'package:social_book/data/services/socket/socket_services.dart';
import 'package:social_book/presentation/bloc/post/post_bloc.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/bloc/profile_logics/profile_logics_bloc.dart';
import 'package:social_book/presentation/bloc/saved_posts/saved_posts_bloc.dart';
import 'package:social_book/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:social_book/presentation/screens/profile/widgets/custom_tab_bar_widget.dart';
import 'package:social_book/presentation/screens/profile/widgets/custom_tabview_widget.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_detail_widget.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_menu.dart';
import 'package:social_book/presentation/screens/settings/settings.dart';
import 'package:social_book/presentation/screens/user_signin/user_signin_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    context.read<SavedPostsBloc>().add(FetchAllSavedPostEvent());
    context.read<ProfileBloc>().add(ProfileInitialFetchEvent());
    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<ProfileBloc>().add(ProfileInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocListener<ProfileLogicsBloc, ProfileLogicsState>(
        listener: (context, state) {
          if (state is ChangeAccountTypeSuccessState) {
            _handleRefresh();
          }
        },
        child: ColorfulSafeArea(
          color: Colors.white,
          child: Scaffold(
            body: RefreshIndicator(
              onRefresh: _handleRefresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                controller: profilePageController,
                children: [
                  BlocConsumer<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      if (state is ProfileFetchingSucessState) {
                        print('User Details: ${state.userDetails}');
                        print('Posts List: ${state.posts}'); // Debug print
                        // ============ Connecting user to socket.io server ============
                        String currentUsername = state.userDetails.username!;
                        log('Current User After SignIn $currentUsername');
                        SocketServices()
                            .connectSocket(currentUsername, context);
                      }
                    },
                    builder: (context, state) {
                      if (state is ProfileFetchingSucessState) {
                        return ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            ProfileDetailsWidget(
                              userModel: state.userDetails,
                              postsList: state.posts,
                              isCurrentUser: false,
                            ),
                            kHeight(50),
                            CustomTabBarWidget(tabController: tabController),
                            kHeight(15),
                            CustomTabviewWidget(
                              profileState: state,
                              tabController: tabController,
                            ),
                          ],
                        );
                      }

                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
