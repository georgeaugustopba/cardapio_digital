import 'package:flutter/material.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';
import 'package:flutter_menu/core/widgets/core_back_button.dart';
import 'package:flutter_menu/features/cart/controllers/cart_controller.dart';
import 'package:flutter_menu/features/checkout/components/cpf_field.dart';
import 'package:flutter_menu/features/checkout/components/price_card.dart';
import 'package:flutter_menu/features/checkout/model/credit_model.dart';
import 'package:flutter_menu/features/checkout/widget/credit_card_widget.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final creditCard = CreditCardModel();
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsTheme.kBackgroundColor,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(12.0),
          child: CoreBackButton(),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: ColorsTheme.kBackgroundColor,
        title: const Text(
          'Realize o Pagamento do seu Pedido!!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: ColorsTheme.kPrimaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: Text(
                      'Pagamento Com Cartão de crédito',
                      style: TextStyle(
                        color: ColorsTheme.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  //cartao de credito
                  CreditCardWidget(creditCard: creditCard),

                  //campo cpf
                  CpfField(creditCard: creditCard),

                  const SizedBox(
                    height: 10,
                  ),
                  //Resumo do Pedido
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                      left: 14.0,
                      right: 14.0,
                      top: 1,
                    ),
                    child: PriceCard(),
                  ),

                  //Botão Do Cartão
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                    ),
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsTheme.kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            cartController.productClean;
                            // print(creditCard);
                          }
                        },
                        child: const Text('Pagar com Cartão de Crédito'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 30,
                    child: Obx(
                      () {
                        return TextButton.icon(
                          onPressed: (cartController.loading.value)
                              ? null
                              : () {
                                  showOrderConfirmation();

                                  // print(result);
                                },
                          icon: const Icon(
                            Icons.api_sharp,
                          ),
                          label: cartController.loading.value
                              ? const CircularProgressIndicator()
                              : Material(
                                  color: Colors.transparent,
                                  clipBehavior: Clip.antiAlias,
                                  child: InkWell(
                                    onTap: () {},
                                    child: const Text(
                                      'Pagar com PIX',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente concluir o pedido?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                'Não',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                'Sim',
              ),
            ),
          ],
        );
      },
    );
  }
}
