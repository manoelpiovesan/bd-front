import 'package:flutter/material.dart';
import 'package:projeto_bd_front/views/home_view.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Projeto BD',
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const HomeView(),
    );
  }
}
