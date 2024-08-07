import 'package:flutter/material.dart';
import 'package:social_book/data/models/post_model/post_model.dart';
import 'package:social_book/presentation/screens/home/widgets/post/post_more_bottom_sheet.dart';

class PostMoreWidget {
  static Future<dynamic> bottomSheet({
    required BuildContext context,
    PostModel? postModel,
    required String userId,
    String? postId,
    bool? onDetail,
  }) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black26,
        useRootNavigator: true,
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return PostMoreBottomSheet(
            postModel: postModel!,
            userId: userId,
            // onDetail: onDetail!,
            postId: postId!,
          );
        });
  }
}
