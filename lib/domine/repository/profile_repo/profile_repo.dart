import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:social_book/core/utils/api_endpoints.dart';
import 'package:social_book/data/model/user_model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:social_book/data/services/shared_preference/shared_preference.dart';

class ProfileRepo {
  static Future<ProfileDetailsModel?> fetchUserDetails() async {
    var client = http.Client();
    String token = await UserToken.getToken();
    String userDetailUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.profile}";
    try {
      var response = await client.get(
        Uri.parse(userDetailUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint('Fetch Users Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        UserModel user = UserModel.fromJson(responseData['user']);
        return ProfileDetailsModel(user: user);
      }
      return null;
    } catch (e) {
      debugPrint('Fetch Users Error: ${e.toString()}');
      return null;
    }
  }
}

class ProfileDetailsModel {
  final UserModel user;

  ProfileDetailsModel({required this.user});
}
