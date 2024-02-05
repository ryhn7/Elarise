part of 'signup.dart';

class SignUpParams {
  final String email;
  final String password;
  String? username;
  String? photoProfile;

  SignUpParams({
    required this.email,
    required this.password,
    this.username,
    this.photoProfile,
  });
}
