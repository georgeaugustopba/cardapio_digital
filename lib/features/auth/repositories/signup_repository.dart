import 'package:either_dart/either.dart';
import 'package:flutter_menu/features/auth/models/signup_response.dart';
import 'package:flutter_menu/features/auth/models/user.dart';
import 'package:flutter_menu/features/auth/pages/auth/datasource/strapi_signup_datasource.dart';

class SignupRepository {
  SignupRepository(this._dataSource);

  final StrapSignupDataSource _dataSource;
  String? jwt;
  //    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MywiaWF0IjoxNjc4OTExOTkwLCJleHAiOjE2ODE1MDM5OTB9.FzBITA_G5wMNPoR43kQAB9p87pg2bm8jIwABzYSfiu8';
  User? user;

  bool get isLogged => jwt != null;

  Future<Either<SignupError, SignupResponse>> signup(
      String username, String email, String password) async {
    final result = await _dataSource.signup(username, email, password);
    return result;
  }
}
