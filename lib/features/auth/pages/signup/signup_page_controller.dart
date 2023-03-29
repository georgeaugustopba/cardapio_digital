import 'package:flutter/widgets.dart';
import 'package:flutter_menu/features/auth/pages/signup/signup_page_actions.dart';
import 'package:flutter_menu/features/auth/repositories/signup_repository.dart';
import 'package:get/get.dart';

class SignupPageController extends GetxController {
  SignupPageController(
    this._actions,
  );

  SignupPageActions? _actions;

  final SignupRepository _repository = Get.find();
  final _userdate = RxString('');
  final _userName = RxString('');
  final _passWord = RxString('');
  final _confirmpass = RxString('');
  final _email = RxString('');

  void setUsername(String t) {
    _userName.value = t;
  }

  void setUserDate(String t) {
    _userdate.value = t;
  }

  void setPassword(String t) {
    _passWord.value = t;
  }

  void setEmail(String t) {
    _email.value = t;
  }

  void setConfirmPass(String t) {
    _confirmpass.value = t;
  }

  bool get _isUsernameValid => _userName.value.length >= 4;
  bool get _isPasswordValid => _passWord.value.length >= 4;
  bool get isDateValid => _userdate.value.length >= 9;

  bool get _isFormValid => _isUsernameValid && _isPasswordValid;

  VoidCallback? get onSignupPressed => _isFormValid ? signup : null;

  @visibleForTesting
  Future<void> signup() async {
    final result = await _repository.signup(
        _userName.value, _email.value, _passWord.value);
    if (result.isLeft) {
      _actions?.showErrorMessage(result.left);
    } else {
      // print(result.right.jwt);
      _actions?.navToHome();
    }
  }

  @override
  void onClose() {
    _actions = null;
  }
}
