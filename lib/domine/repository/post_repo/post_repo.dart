import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:social_book/core/utils/api_endpoints.dart';
import 'package:social_book/data/model/post_model/post_model.dart';
import 'package:social_book/data/services/shared_preference/shared_preference.dart';

class PostRepo{
    static Future<List<PostModel>> fetchAllPosts() async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String postListUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.allPosts}";
    List<PostModel> posts = [];
    try {
      var response = await dio.get(
        postListUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      debugPrint('Fetch Post Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final List postsList = response.data;
        for (int i = 0; i < postsList.length; i++) {
          PostModel post = PostModel.fromJson(postsList[i]);
          if (!post.isBlocked) {
            posts.add(post);
          }
        }
        return posts;
      }
      return [];
    } catch (e) {
      debugPrint('Fetch Post Error: ${e.toString()}');
      return [];
    }
  }

    static Future<String> createPost(
      String location, String description, List<String> imageUrlList) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String createPostUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.createPost}";
    try {
      var data = {
        "postData": {
          "description": description,
          'image': imageUrlList,
          "location": location,
        }
      };
      var response = await dio.post(createPostUrl,
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));
      debugPrint('Create Post Status: ${response.statusCode}');

      if (response.statusCode == 201) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint('Create Post Error: $e');
      return '';
    }
  }
}