import 'package:flutter/material.dart';
import 'package:projeto_bd_front/views/home.dart';

void main() {
  runApp(const ProjetoBD());
}

///
///
///
class ProjetoBD extends StatelessWidget {
  ///
  ///
  ///
  const ProjetoBD({super.key});

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      title: 'Projeto BD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeView(),
    );
  }
}
