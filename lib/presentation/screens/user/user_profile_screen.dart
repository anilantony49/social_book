import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_detail_widget.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserByIdBloc, UserByIdState>(
        builder: (context, state) {
          // if(state is FetchUserByIdLoadingState){
          //   return UserProfilePageLoading()
          // }

          if (state is FetchUserByIdSuccessState) {
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
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(onSelected: (String value) {
                      if (value == 'Log Out') {
                        // showLogoutDialog();
                      }
                    }, itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem<String>(
                            value: 'Send Message', child: Text('Send Message')),
                        const PopupMenuItem<String>(
                            value: 'Report Account',
                            child: Text('Report Account')),
                        const PopupMenuItem<String>(
                            value: 'Cancel', child: Text('Cancel'))
                      ];
                    })
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      ProfileDetailWidget(
                        userModel: state.userModel,
                        postsList: state.posts,
                        isCurrentUser: widget.isCurrentUser,
                      )
                    ],
                  ),
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
