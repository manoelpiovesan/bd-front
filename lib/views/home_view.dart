import 'package:flutter/material.dart';
import 'package:projeto_bd_front/utils/my_drawer.dart';
import 'package:projeto_bd_front/views/dashboard_view.dart';
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
      appBar: AppBar(title: const Text('Página Inicial')),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            /// Employee List
            ListTile(
              title: const Text('Funcionários'),
              subtitle: const Text('Lista de funcionários'),
              leading: const Icon(Icons.people),
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
              leading: const Icon(Icons.work),
              onTap:
                  () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder:
                          (final BuildContext context) =>
                              const DepartmentList(),
                    ),
                  ),
            ),

            /// Dashboard
            ListTile(
              title: const Text('Estatísticas'),
              subtitle: const Text('Visão geral do sistema'),
              leading: const Icon(Icons.dashboard),
              onTap:
                  () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder:
                          (final BuildContext context) => const DashboardView(),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
