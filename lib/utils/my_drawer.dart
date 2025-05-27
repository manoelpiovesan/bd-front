import 'package:flutter/material.dart';
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
            child: Text(
              'Projeto BD',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),

          /// Funcionários
          ListTile(
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
            leading: const Icon(Icons.business),
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
        ],
      ),
    );
  }
}
