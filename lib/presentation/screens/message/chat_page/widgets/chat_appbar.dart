import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/cubit/online_users/online_users_cubit.dart';

class ChatAppbar extends StatelessWidget {
  const ChatAppbar({
    super.key,
    required this.user,
  });
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(AppIcons.arrowleftios),
          ),
          CircleAvatar(
            backgroundImage: user.profilePicture == ""
                ? Image.asset(profilePlaceholder).image
                : NetworkImage(user.profilePicture!),
          ),
          kWidth(15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.fullName!,
                style: const TextStyle(fontSize: 15),
              ),
              kHeight(2),
              BlocBuilder<OnlineUsersCubit, List<String>>(
                builder: (context, state) {
                  return state.contains(user.username)
                      ? const Text(
                          'Active now',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        )
                      : const SizedBox();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
