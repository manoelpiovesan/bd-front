import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

///
///
///
class MyApp extends StatelessWidget {
  ///
  ///
  ///
  const MyApp({super.key});

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Text('Teste'),
    );
  }
}
