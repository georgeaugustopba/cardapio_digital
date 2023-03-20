import 'package:flutter/cupertino.dart';
import 'package:flutter_menu/features/auth/pages/auth/auth_page_actions.dart';
import 'package:flutter_menu/features/auth/repositories/auth_repository.dart';
import 'package:get/get.dart';

class AuthPageController extends GetxController {

  AuthPageController(this._actions);

  AuthPageActions? _actions;
  final AuthRepository _repository = Get.find();

  final _username = RxString('');
  final _password = RxString('');

  void setUsername(String t) {
    _username.value = t;
  }

  void setPassword(String t) {
    _password.value = t;
  }

  bool get _isUsernameValid => _username.value.length >= 4;
  bool get _isPasswordValid => _password.value.length >= 4;

  bool get _isFormValid => _isUsernameValid && _isPasswordValid;

  VoidCallback? get onLoginPressed => _isFormValid ? login : null;

  @visibleForTesting
  Future<void> login() async {
    final result = await _repository.login(_username.value, _password.value);
    if(result.isLeft) {
      _actions?.showErrorMessage(result.left);
    } else {
      print(result.right.jwt);
      _actions?.navToDashboard();
    }
  }

  @override
  void onClose() {
    _actions = null;
  }
}