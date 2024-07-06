import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:social_book/core/utils/api_endpoints.dart';
import 'package:social_book/data/model/post_model/post_model.dart';
import 'package:social_book/data/services/shared_preference/shared_preference.dart';

class PostRepo {
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

  static Future<String> removePost(String postId) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String removePostUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.removePost}$postId";
    try {
      var response = await dio.delete(removePostUrl,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));
      debugPrint('Remove Post Status: ${response.statusCode}');
      if (response.statusCode == 201) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint('Remove Post Error: $e');
      return '';
    }
  }

  static Future<String> likePost(String postId) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String likePostUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.likePost}$postId";
    try {
      var response = await dio.patch(
        likePostUrl,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );
      debugPrint('Like Post Status: ${response.statusCode}');
      if (response.statusCode == 201) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint('Like Post Error: $e');
      return '';
    }
  }

  static Future<String> unlikePost(String postId) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String likePostUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.unlikePost}$postId";
    try {
      var response = await dio.patch(
        likePostUrl,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );
      debugPrint('Unlike Post Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint('Unlike Post Error: $e');
      return '';
    }
  }

    static Future<CommentModel?> addComment(String comment, String postId) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String addCommentUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.addComment}";
    var data = {
      "postId": postId,
      "comment": comment,
    };
    try {
      var response = await dio.post(
        addCommentUrl,
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );
      debugPrint('Add Comment Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        var jsonResponse = response.data['data'];
        CommentModel commentModel = CommentModel.fromJson(jsonResponse);
        return commentModel;
      }
      return null;
    } catch (e) {
      debugPrint('Add Comment Error: $e');
      return null;
    }
  }

    static Future<String> deleteComment(String commentId, String postId) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String deleteCommentUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.deleteComment}";
    var data = {
      "postId": postId,
      "commentId": commentId,
    };
    try {
      var response = await dio.post(
        deleteCommentUrl,
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );
      debugPrint('Delete Comment Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint('Delete Comment Status: $e');
      return '';
    }
  }
}
