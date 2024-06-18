import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_book/core/utils/api_endpoints.dart';
import 'package:social_book/data/model/user_model/user_model.dart';
import 'package:social_book/data/services/shared_preference/shared_preference.dart';

class AuthRepo {
  static Future<SignUpResult> userSignUp({required UserModel user}) async {
    var client = http.Client();
    String signUPUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.userSignUp}";
    try {
      var response = await client.post(
        Uri.parse(signUPUrl),
        body: jsonEncode(user),
        headers: {'Content-Type': 'application/json'},
      );

      var jsonResponse = jsonDecode(response.body);
      debugPrint('User Sign Up Status: ${response.statusCode}');
      debugPrint('User Sign Up Body: ${response.body}');

         if (response.statusCode == 201) {
        await UserAuthStatus.saveUserStatus(true);
        await UserToken.saveToken(jsonResponse['token']);
        await CurrentUserId.saveUserId(jsonResponse['userId']);
        return SignUpResult(status: 'success', responseBody: response.body);
      }
      if (response.statusCode == 400) {
        return SignUpResult(status: 'invalid-otp', responseBody: null);
      }
       if (response.statusCode == 409) {
        if (jsonResponse['error'] ==
            "Username Already Taken. Please Choose different one or login instead") {
          return SignUpResult(status: 'username-exists', responseBody: null);
        } else if (jsonResponse['error'] ==
            "A user with this email address already exist. Please login instead") {
          return SignUpResult(status: 'email-exists', responseBody: null);
        } else if (jsonResponse['error'] ==
            "A user with this Phone Number already exist. Please login instead") {
          return SignUpResult(status: 'phoneno-exists', responseBody: null);
        }
      }
       return SignUpResult(status: 'error', responseBody: null);
    } catch (e) {
       debugPrint('User Sign Up Error: $e');
       return SignUpResult(status: 'error', responseBody: null);
    }
  }
}

class SignUPResult {
  final String? status;
  final dynamic responseBody;

  SignUPResult({this.status, this.responseBody});
}

class SignUpResult {
  final String? status;
  final dynamic responseBody;

  SignUpResult({this.status, this.responseBody});
}
