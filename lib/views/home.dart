import 'package:flutter/material.dart';
import 'package:projeto_bd_front/views/widgets/lists/employee_list.dart';

///
///
///
class HomeView extends StatelessWidget {
  ///
  ///
  ///
  const HomeView({super.key});

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const SingleChildScrollView(child: EmployeeList()),
    );
  }
}
