class UserResponseModel {
  final bool status;
  final String message;
  final User? user;
  final UserData? data;
  final String? error;

  UserResponseModel({
    required this.status,
    required this.message,
    this.user,
    this.data,
    this.error,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      status: json['status'],
      message: json['message'],
      user: json.containsKey('user') ? User.fromJson(json['user']) : null,
      data: json.containsKey('data') ? UserData.fromJson(json['data']) : null,
      error: json['error'],
    );
  }
}

class User {
  final String accessToken;
  final String tokenType;

  User({
    required this.accessToken,
    required this.tokenType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }
}

class UserData {
  final int userId;
  final String name;
  final String email;
  final String phone;
  final String? image;
  final String? role;
  final String address;
  final List<String> disabilities;

  UserData({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    this.image,
    this.role,
    required this.address,
    required this.disabilities,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      role: json.containsKey('role') ? json['role']:"user",
      address: json['address'],
      disabilities: List<String>.from(json['disabilities']),
    );
  }
}