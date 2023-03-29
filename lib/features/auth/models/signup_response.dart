import 'package:flutter_menu/features/auth/models/user.dart';

class SignupResponse {
  SignupResponse({
    required this.jwt,
    required this.user,
  });

  final String jwt;
  final User user;

  factory SignupResponse.fromJson(Map<String, dynamic> map) {
    return SignupResponse(
      jwt: map['jwt'] as String,
      user: User.fromJson(map['user']),
    );
  }
}
