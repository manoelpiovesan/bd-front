import 'package:flutter/material.dart';
import 'package:projeto_bd_front/utils/my_drawer.dart';
import 'package:projeto_bd_front/views/widgets/lists/department_list.dart';
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
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            /// Employee List
            ListTile(
              title: const Text('Funcionários'),
              subtitle: const Text('Lista de funcionários'),
              leading: const Icon(Icons.people),
              trailing: const Icon(Icons.arrow_forward),
              onTap:
                  () => Navigator.of(context).push(
                    MaterialPageRoute<EmployeeList>(
                      builder:
                          (final BuildContext context) => const EmployeeList(),
                    ),
                  ),
            ),

            /// Department List
            ListTile(
              title: const Text('Departamentos'),
              subtitle: const Text('Lista de departamentos'),
              leading: const Icon(Icons.business),
              trailing: const Icon(Icons.arrow_forward),
              onTap:
                  () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder:
                          (final BuildContext context) =>
                              const DepartmentList(),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
