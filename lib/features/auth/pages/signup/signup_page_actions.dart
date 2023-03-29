import 'package:flutter_menu/features/auth/pages/auth/datasource/strapi_signup_datasource.dart';

abstract class SignupPageActions {
  void navToHome();
  void showErrorMessage(SignupError error);
}
