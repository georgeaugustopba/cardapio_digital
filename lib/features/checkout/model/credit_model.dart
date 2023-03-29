import 'package:credit_card_type_detector/credit_card_type_detector.dart';

class CreditCardModel {
  CreditCardModel({
    this.number,
    this.cpf,
    this.holder,
    this.expirationDate,
    this.securityCode,
    this.brand,
  });

  String? number;
  String? cpf;
  String? holder;
  String? expirationDate;
  String? securityCode;
  String? brand;

  void setHolder(String? name) => holder = name;
  void setExpirationDate(String? date) => expirationDate = date;
  void setCVV(String? cvv) => securityCode = cvv;
  void setNumber(String? number) {
    this.number = number;
    brand = detectCCType(number!.replaceAll(' ', ''))
        .toString()
        .toUpperCase()
        .split(".")
        .last;
  }

  @override
  String toString() {
    return 'CreditCardModel(number: $number, cpf: $cpf, holder: $holder, expirationDate: $expirationDate, securityCode: $securityCode, brand: $brand)';
  }
}
