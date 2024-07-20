import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_book/core/utils/app_icons.dart';
import 'package:social_book/core/utils/constants.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/data/models/user_model/user_model.dart';
import 'package:social_book/presentation/bloc/profile/profile_bloc.dart';
import 'package:social_book/presentation/screens/home/widgets/post/post_more_widget.dart';
import 'package:social_book/presentation/widgets/fadein_animate.dart';
import 'package:social_book/presentation/screens/profile/widgets/profile_circle_widget.dart';

class PostUserWidget extends StatefulWidget {
  final UserModel? userModel;
  final PostModel postModel;
  const PostUserWidget({
    super.key,
    this.userModel,
    required this.postModel,
  });

  @override
  State<PostUserWidget> createState() => _PostUserWidgetState();
}

class _PostUserWidgetState extends State<PostUserWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 50,
            height: 50,
            child: ProfileCircleWidget(
                radius: 40,
                imageWidget: widget.postModel.user!.profilePicture == "" ||
                        widget.userModel!.profilePicture == ""
                    ? Image.asset(profilePlaceholder)
                    : FadedImageLoading(
                        imageUrl: widget.postModel.user!.profilePicture ??
                            widget.userModel!.profilePicture!))),
        kWidth(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.postModel.user!.fullName ??
                  widget.userModel!.fullName!.capitalize(),
              style: const TextStyle(fontSize: 15),
            ),
            kWidth(15),
            kHeight(5),
            SizedBox(
              width: 150,
              child: Text(
                widget.postModel.location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                filterPostTime(DateTime.parse(widget.postModel.createdDate ??
                    widget.userModel!.createdAt!)),
                style: const TextStyle(fontSize: 11, color: Colors.black),
              ),
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileFetchingSucessState) {
                  return InkWell(
                    onTap: () {
                      PostMoreWidget.bottomSheet(
                        context: context,
                        postModel: widget.postModel,
                        userId: state.userDetails.id!,
                        postId: widget.userModel!.id!,
                        // onDetail: widget.onDetail,
                      );
                    },
                    child: const Icon(AppIcons.more_vert),
                  );
                }
                return const Icon(AppIcons.more_vert);
              },
            ),
          ],
        ),
      ],
    );
  }
}
