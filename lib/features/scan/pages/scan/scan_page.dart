import 'package:flutter/material.dart';
import 'package:flutter_menu/core/constants/colors_constants.dart';
import 'package:flutter_menu/core/widgets/core_page_title.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CorePageTitle(
                title: 'Bem-vindo(a)! a Loja online - T&A Confecções',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Text(
                  'Para acessar o Catálogo T&A Confecções, abra sua câmera e escaneie o QR Code localizado em sua mesa.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorsTheme.kSecondaryColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Icon(
                      Icons.qr_code_scanner,
                      size: 200,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
