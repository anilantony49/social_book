import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/alerts_and_navigation.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/services/socket/socket_services.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/bloc/profile_logics/profile_logics_bloc.dart';
import 'package:social_book/presentation/screens/profile/widgets/custom_tab_bar_widget.dart';
import 'package:social_book/presentation/screens/profile/widgets/custom_tabview_widget.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_detail_widget.dart';
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
    tabController = TabController(length: 2, vsync: this);
    context.read<ProfileBloc>().add(ProfileInitialFetchEvent());
    super.initState();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<ProfileBloc>().add(ProfileInitialFetchEvent());
  }

  void showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // dismiss the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add your logout logic here
                Navigator.of(context).pop(); // dismiss the dialog
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
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
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: _handleRefresh,
            child: BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileFetchingSucessState) {
                  // ============ Connecting user to socket.io server ============
                  String currentUsername = state.userDetails.username!;
                  log('Current User After SignIn $currentUsername');
                  SocketServices().connectSocket(currentUsername, context);
                }
              },
              builder: (context, state) {
                if (state is ProfileFetchingLoadingState) {
                  // return const ProfilePageLoading();
                }

                if (state is ProfileFetchingSucessState) {
                  return Column(
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 60),
                                child: Text(
                                  'My Profile',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          PopupMenuButton<String>(onSelected: (String value) {
                            if (value == 'Log Out') {
                              showLogoutDialog();
                            }
                          }, itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem<String>(
                                  value: 'Log Out', child: Text('Log Out'))
                            ];
                          })
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            ProfileDetailWidget(
                              userModel: state.userDetails,
                              isCurrentUser: false,
                            ),
                            CustomTabBarWidget(tabController: tabController),
                            const SizedBox(height: 15),
                            CustomTabviewWidget(
                              tabController: tabController,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
