class UserModel {
  final String? id;
  final String? username;
  final String? password;
  final String? email;
  final int? phoneNumber;
  final String? accountType;
  final String? fullName;
  final String? otp;
  final String? bio;
  final String? profilePicture;
  final String? createdAt;
  final bool? isBlocked;
  final List? followers;
  final List? following;

  UserModel({
    this.id,
    this.username,
    this.password,
    this.email,
    this.phoneNumber,
    this.accountType,
    this.fullName,
    this.otp,
    this.bio,
    this.profilePicture,
    this.createdAt,
    this.isBlocked,
    this.followers,
    this.following,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['_id'],
        username: json['username'],
        password: json['password'],
        email: json['email'],
        phoneNumber: json['phonenumber'],
        accountType: json['account_type'],
        profilePicture: json['profile_picture'],
        bio: json['bio'],
        fullName: json['fullname'],
        otp: json['otp'],
        createdAt: json['createdAt'],
        isBlocked: json['isBlocked'],
        followers: json['followers'],
        following: json['following'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "password": password,
        "email": email,
        "phonenumber": phoneNumber,
        "account_type": accountType,
        "profile_picture": profilePicture,
        "bio": bio,
        "fullname": fullName,
        "otp": otp,
        "createdAt": createdAt,
        "isBlocked": isBlocked,
        "followers": followers,
        "following": following,
      };
}
