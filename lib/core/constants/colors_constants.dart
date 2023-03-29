import 'package:flutter/material.dart';

abstract class ColorsTheme {
// Colors usadas em todos os projetos

//Cores primarias de botao, menu etc
  static const kPrimaryColor = Color.fromARGB(255, 207, 169, 47);
//Cores primarias do app
  static const kSecondaryColor = Color(0xff212730);
  // Color.fromRGBO(255, 211, 170, 46);

//cor primaria dos textos
  static const kTextColor = Color.fromARGB(255, 207, 169, 47);
  static const kTextColorWite = Color.fromARGB(255, 246, 246, 246);

//cor primaria do Background
  static const kBackgroundColor = Color.fromARGB(255, 53, 53, 52);

//padding base
  static const double kDefaultPadding = 20.0;
}
