class ApiEndPoints {
  static String baseUrl = 'http://tweel.online';
  static String userSignUp = '/signup';
  static String userVerifyOtp = "/signup-send-otp";
  static String profile = '/me';
  static String userSignIn = '/login';
  static String editUserProfile = '/profile/edit';
  static String socketUrl = 'http://tweel.online';
  static String changeAccountType = "/account/type";
  static String allPosts = "/posts";
  static String createPost = "/createpost";
  static String editPost = "/post/";
  static String removePost = "/post/";
  static String forgetSendOtp = "/forget-send-otp";
  static String resetPassword = "/forget-password";

  static String likePost = "/post/like/";
  static String unlikePost = "/post/unlike/";

  static String addComment = "/post/comment/add";
  static String deleteComment = "/post/comment/delete";

  static String allUsers = '/users';
  static String user = '/user/';

  static String followUser = "/follow/";
  static String unfollowUser = "/unfollow/";

  static String userSearch = "/search";
  static String allSavedPosts = "/saved-post";
  static String savePost = "/save-post/";
  static String unsavePost = "/unsave-post/";
}
