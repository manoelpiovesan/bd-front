import 'package:flutter/material.dart';
import 'package:projeto_bd_front/views/dashboard_view.dart';
import 'package:projeto_bd_front/views/home_view.dart';
import 'package:projeto_bd_front/views/playground_view.dart';
import 'package:projeto_bd_front/views/widgets/lists/department_list.dart';
import 'package:projeto_bd_front/views/widgets/lists/employee_list.dart';

///
///
///
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueGrey),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.table_view, size: 48, color: Colors.white),
                Text(
                  'Projeto de \n Banco de Dados',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          ),

          /// Página Inicial
          ListTile(
            subtitle: const Text('Voltar para a página inicial'),
            leading: const Icon(Icons.home),
            title: const Text('Página Inicial'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(
                  builder: (final BuildContext context) => const HomeView(),
                ),
              );
            },
          ),

          /// Funcionários
          ListTile(
            subtitle: const Text('Gerenciamento de funcionários'),
            leading: const Icon(Icons.people),
            title: const Text('Funcionários'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (final BuildContext context) => const EmployeeList(),
                ),
              );
            },
          ),

          /// Departamentos
          ListTile(
            subtitle: const Text('Gerenciamento de departamentos'),
            leading: const Icon(Icons.work),
            title: const Text('Departamentos'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder:
                      (final BuildContext context) => const DepartmentList(),
                ),
              );
            },
          ),

          /// Dashboard
          ListTile(
            subtitle: const Text('Visão geral do sistema'),
            leading: const Icon(Icons.dashboard),
            title: const Text('Estatísticas'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder:
                      (final BuildContext context) => const DashboardView(),
                ),
              );
            },
          ),

          /// Playground
          ListTile(
            subtitle: const Text('Área de testes e experimentos'),
            leading: const Icon(Icons.beach_access),
            title: const Text('Playground'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder:
                      (final BuildContext context) => const PlaygroundView(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
