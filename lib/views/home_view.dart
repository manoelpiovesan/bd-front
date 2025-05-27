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
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1,
          children: <Widget>[
            // Funcionários
            GestureDetector(
              onTap:
                  () => Navigator.of(context).push(
                    MaterialPageRoute<EmployeeList>(
                      builder:
                          (final BuildContext context) => const EmployeeList(),
                    ),
                  ),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(Icons.people, size: 32),
                      const SizedBox(height: 8),
                      Text(
                        'Funcionários',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Departamentos
            GestureDetector(
              onTap:
                  () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder:
                          (final BuildContext context) =>
                              const DepartmentList(),
                    ),
                  ),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(Icons.work, size: 32),
                      const SizedBox(height: 8),
                      Text(
                        'Departamentos',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Estatísticas
            GestureDetector(
              onTap:
                  () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder:
                          (final BuildContext context) => const DashboardView(),
                    ),
                  ),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(Icons.dashboard, size: 32),
                      const SizedBox(height: 8),
                      Text(
                        'Estatísticas',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
