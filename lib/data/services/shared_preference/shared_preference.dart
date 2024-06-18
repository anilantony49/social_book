import 'package:shared_preferences/shared_preferences.dart';

class UserToken {
  static saveToken(String token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('TOKEN', token);
  }
}

class CurrentUserId {
  static saveUserId(String userId) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('USERID', userId);
  }
}

// Shared preference for managing Sign in and Sign up
class UserAuthStatus {
  static Future<bool> getUserStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final bool? status = preferences.getBool('SIGNIN');
    return status ?? false;
  }

  static Future<bool> isUserOnInitial() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final bool? status = preferences.getBool('ON_INITIAL');
    return status ?? false;
  }

  static saveUserStatus(bool status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('SIGNIN', status);
  }
}
