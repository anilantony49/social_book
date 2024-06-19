class UserModel {
  final String? id;
  final String? username;
  final String? password;
  final String? email;
  final int? phoneNumber;
  final String? fullName;
  final String? otp;

  UserModel(
      {this.id,
      this.username,
      this.password,
      this.email,
      this.phoneNumber,
      this.fullName,
      this.otp});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['_id'],
        username: json['username'],
        password: json['password'],
        email: json['email'],
        phoneNumber: json['phonenumber'],
        fullName: json['fullname'],
        otp: json['otp'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "password": password,
        "email": email,
        "phonenumber": phoneNumber,
        "fullname": fullName,
        "otp": otp,
      };
}
