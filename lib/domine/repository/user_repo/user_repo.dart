import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:social_book/core/utils/api_endpoints.dart';
import 'package:social_book/data/model/post_model/post_model.dart';
import 'package:social_book/data/model/user_model/user_model.dart';
import 'package:social_book/data/services/shared_preference/shared_preference.dart';

class UserRepo{
    static Future<UserDetailsModel?> fetchUserDetailsById(String userId) async {
    Dio dio = Dio();
    String token = await UserToken.getToken();
    String userDetailUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.user}$userId";
    List<PostModel> posts = [];
    try {
      var response = await dio.get(
        userDetailUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      debugPrint('Fetch User By Id Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        UserModel user = UserModel.fromJson(responseData['user']);
        final List postsList = responseData['posts'];
        for (int i = 0; i < postsList.length; i++) {
          PostModel post = PostModel.fromJson(postsList[i]);
          if (!post.isBlocked) {
            posts.add(post);
          }
        }
        return UserDetailsModel(user: user, posts: posts);
      }
      return null;
    } catch (e) {
      debugPrint('Fetch User By Id Error: $e');
      return null;
    }
  }
}

class UserDetailsModel {
  final UserModel user;
  final List<PostModel> posts;

  UserDetailsModel({
    required this.user,
    required this.posts,
  });
}
