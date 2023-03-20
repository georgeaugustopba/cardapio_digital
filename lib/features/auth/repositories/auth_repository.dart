import 'package:either_dart/either.dart';
import 'package:flutter_menu/features/auth/datasources/strapi_auth_datasource.dart';
import 'package:flutter_menu/features/auth/models/login_response.dart';
import 'package:flutter_menu/features/auth/models/user.dart';

class AuthRepository {
  AuthRepository(this._datasource);

  final StrapiAuthDatasource _datasource;

  String? jwt =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjc4NzUyODM0LCJleHAiOjE2ODEzNDQ4MzR9.BIN1oeRBjC1cPXkxAkvdzDms99L6Gv7_FfikIFpDKLE';
  User? user;

  bool get isLoggedIn => jwt != null;

  Future<Either<LoginError, LoginResponse>> login(
      String identifier, String password) async {
    final result = await _datasource.login(identifier, password);
    if (result.isRight) {
      jwt = result.right.jwt;
      user = result.right.user;
    }
    return result;
  }
}
