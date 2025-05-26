import 'package:flutter/material.dart';
import 'package:projeto_bd_front/consumers/employee_consumer.dart';
import 'package:projeto_bd_front/models/employee.dart';

///
///
///
class EmployeeList extends StatefulWidget {
  ///
  ///
  ///
  const EmployeeList({super.key});

  ///
  ///
  ///
  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

///
///
///
class _EmployeeListState extends State<EmployeeList> {
  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return FutureBuilder<List<Employee>?>(
      future: EmployeeConsumer().getAll(),
      builder: (
        final BuildContext context,
        final AsyncSnapshot<List<Employee>?> snapshot,
      ) {
        if (snapshot.hasData) {
          final List<Employee>? employees = snapshot.data;

          if (employees != null && employees.isNotEmpty) {
            return ListView.builder(
              itemCount: employees.length,
              itemBuilder: (final BuildContext context, final int index) {
                final Employee employee = employees[index];
                return ListTile(title: Text(employee.name));
              },
            );
          } else {
            return const Center(child: Text('Sem funcionários cadastrados'));
          }
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
