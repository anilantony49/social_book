import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_detail_widget.dart';
import 'package:social_book/presentation/screens/user/widgets/post_button.dart';
import 'package:social_book/presentation/screens/user/widgets/post_grid_view.dart';
import 'package:social_book/presentation/screens/user/widgets/user_profile_detail_widget.dart';
import 'package:social_book/presentation/widgets/refresh_widget.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({
    super.key,
    required this.userId,
    required this.isCurrentUser,
  });

  final String userId;
  final bool isCurrentUser;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    context.read<UserByIdBloc>().add(FetchUserByIdEvent(userId: widget.userId));
    super.initState();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<UserByIdBloc>().add(FetchUserByIdEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      child: RefreshWidget(
        onRefresh: _handleRefresh,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<UserByIdBloc, UserByIdState>(
            builder: (context, state) {
              // if(state is FetchUserByIdLoadingState){
              //   return UserProfilePageLoading()
              // }

              if (state is FetchUserByIdSuccessState) {
                return ListView(
                  children: [
                    widget.isCurrentUser
                        ? ProfileDetailsWidget(
                            userModel: state.userModel,
                            postsList: state.posts,
                            isCurrentUser: widget.isCurrentUser,
                          )
                        : UserProfileDetailsWidget(
                            userModel: state.userModel,
                            postsList: state.posts,
                            userId: widget.userId,
                          ),
                    kHeight(55),
                    accountDetails(state),
                  ],
                );
              }
              return const Center(
                child: Text('No data'),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget accountDetails(FetchUserByIdSuccessState state) {
    return Column(
      children: [
        if (state.posts.isNotEmpty) const PostButton(),
        kHeight(20),
        PostGridView(state: state),
      ],
    );
  }
}
