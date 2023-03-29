import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final RxString _cardNumber = ''.obs;
  final RxString _cardValidade = ''.obs;
  final RxString _cardTitular = ''.obs;
  final RxString _cardCvv = ''.obs;

  String get cardNumber => _cardNumber.value;
  String get cardValidade => _cardValidade.value;
  String get cardTitular => _cardTitular.value;
  String get cardCvv => _cardCvv.value;

  void setCardNumber(String t) {
    _cardNumber.value = t;
  }

  void setCrdValidade(String t) {
    _cardValidade.value = t;
  }

  void setCardTitular(String t) {
    _cardTitular.value = t;
  }

  void setCardCvv(String t) {
    _cardTitular.value = t;
  }
}
