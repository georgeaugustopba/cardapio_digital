import 'package:flutter/material.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';
import 'package:flutter_menu/core/routes/app_routes.dart';
import 'package:flutter_menu/core/widgets/core_elevated_button.dart';
import 'package:flutter_menu/core/widgets/core_text_buttom.dart';
import 'package:flutter_menu/core/widgets/core_text_field.dart';
import 'package:flutter_menu/features/auth/pages/auth/datasource/strapi_signup_datasource.dart';
import 'package:flutter_menu/features/auth/pages/signup/signup_page_actions.dart';
import 'package:flutter_menu/features/auth/pages/signup/signup_page_controller.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget implements SignupPageActions {
  SignUpPage({super.key});
  late final SignupPageController controller =
      Get.put(SignupPageController(this));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: ColorsTheme.kSecondaryColor,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Crie sua Conta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  CoreTextField(
                    title: 'Usuário',
                    hint: 'Informe seu usuário ',
                    onChanged: controller.setUsername,
                  ),
                  const SizedBox(height: 8),
                  CoreTextField(
                    title: 'E-mail',
                    hint: 'Informe seu e-mail  ',
                    onChanged: controller.setEmail,
                  ),
                  const SizedBox(height: 8),
                  CoreTextField(
                    title: 'Senha',
                    hint: 'Informe sua Senha',
                    onChanged: controller.setPassword,
                    obscure: true,
                  ),
                  //    CoreTextField(
                  //      title: ' Confirmar Senha',
                  //      hint: 'Informe sua senha novamente',
                  //      onChanged: controller.setPassword,
                  //      obscure: true,
                  //    ),
                  //    const SizedBox(height: 8),
                  //    CoreTextField(
                  //      title: 'Aniversário',
                  //      hint: 'Ex: 30/01/1990',
                  //      onChanged: controller.setUserDate,
                  //    ),
                  const SizedBox(height: 12),
                  Obx(
                    () => CoreElevatedButton(
                      onPressed: controller.onSignupPressed,
                      title: 'Criar Conta',
                    ),
                  ),
                  const SizedBox(height: 12),
                  CoreTextButtom(
                    color: ColorsTheme.kBackgroundColor,
                    ontap: () => Get.toNamed(AppRoutes.auth.path),
                    title: 'Fazer Login',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void showErrorMessage(SignupError error) {
    Get.snackbar(
      'Um erro ocorreu',
      error.message,
      backgroundColor: Colors.white,
    );
  }

  @override
  void navToHome() {
    Get.offNamed(AppRoutes.menu.path);
  }
}
