import 'package:flutter/material.dart';

abstract class ColorsTheme {
// Colors usadas em todos os projetos

//Cores primarias de botao, menu etc
  static const kPrimaryColor = Color(0xfff00000);
//Cores primarias do app
  static const kSecondaryColor = Color.fromARGB(255, 0, 0, 0);

//cor primaria dos textos
  static const kTextColor = Color.fromARGB(255, 19, 9, 6);

//cor primaria do Background
  static const kBackgroundColor = Color(0xffffb0b9);

//padding base
  static const double kDefaultPadding = 20.0;
}
