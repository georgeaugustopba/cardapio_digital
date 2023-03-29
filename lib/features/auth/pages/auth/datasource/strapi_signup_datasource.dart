import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_menu/features/auth/models/signup_response.dart';

class StrapSignupDataSource {
  StrapSignupDataSource(this._dio);

  final Dio _dio;

  Future<Either<SignupError, SignupResponse>> signup(
    String username,
    String email,
    String password,
  ) async {
    try {
      final response = await _dio.post('/auth/local/register', data: {
        'username': username,
        'email': email,
        'password': password,
      });

      final signupResponse = SignupResponse.fromJson(response.data);

      // print(response.data);
      return Right(signupResponse);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        return const Left(SignupError.invaLidCredentials);
      }
      return const Left(SignupError.unexpectedError);
    }
  }
}

enum SignupError {
  invaLidCredentials('As credenciais estão erradas'),
  unexpectedError('Algo inesperado ocorreu');

  const SignupError(this.message);
  final String message;
}
