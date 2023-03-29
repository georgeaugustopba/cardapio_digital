import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';
import 'package:flutter_menu/core/widgets/core_elevated_button.dart';
import 'package:flutter_menu/core/widgets/core_text_field.dart';
import 'package:flutter_menu/features/cart/controllers/cart_controller.dart';
import 'package:get/get.dart';

class ShowUserInfoDialog {
  final CartController controller = Get.find();

  void showUserInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: ColorsTheme.kBackgroundColor,
          child: Container(
            width: 400,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Quase lá!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Precisamos saber um pouco sobre você para finalizar seu pedido...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                CoreTextField(
                  initialValue: controller.userName,
                  title: 'Nome',
                  hint: 'Seu nome',
                  textInputType: TextInputType.name,
                  onChanged: controller.setUserName,
                  color: ColorsTheme.kPrimaryColor,
                  textColor: const TextStyle(
                    color: ColorsTheme.kBackgroundColor,
                  ),
                ),
                const SizedBox(height: 16),
                CoreTextField(
                  initialValue: controller.userPhone,
                  title: 'Celular',
                  hint: '(99) 91234-5678',
                  textInputType: TextInputType.phone,
                  formatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  onChanged: controller.setUserPhone,
                  color: ColorsTheme.kPrimaryColor,
                ),
                const SizedBox(height: 16),
                CoreTextField(
                  initialValue: controller.userCep,
                  title: 'Cep',
                  hint: '79.970-000',
                  textInputType: TextInputType.number,
                  formatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter(),
                  ],
                  onChanged: controller.setUserCep,
                  color: ColorsTheme.kPrimaryColor,
                ),
                const SizedBox(height: 16),
                CoreTextField(
                  initialValue: controller.userCep,
                  title: 'Rua e Número',
                  hint: 'Rua São João do campo, 123',
                  textInputType: TextInputType.number,
                  onChanged: controller.setUserRua,
                  color: ColorsTheme.kPrimaryColor,
                ),
                const SizedBox(height: 16),
                CoreTextField(
                  initialValue: controller.userCep,
                  title: 'Complemento',
                  hint: 'Apartamento, 23',
                  textInputType: TextInputType.number,
                  onChanged: controller.setUserComplemento,
                  color: ColorsTheme.kPrimaryColor,
                ),
                const SizedBox(height: 32),
                Obx(() {
                  return CoreElevatedButton(
                    onPressed:
                        controller.isFormValid ? controller.sendOrder : null,
                    title: 'Enviar pedido',
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
