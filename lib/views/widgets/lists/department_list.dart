import 'package:flutter/material.dart';
import 'package:projeto_bd_front/consumers/department_consumer.dart';
import 'package:projeto_bd_front/models/department.dart';
import 'package:projeto_bd_front/models/employee.dart';
import 'package:projeto_bd_front/views/widgets/edits/department_edit.dart';
import 'package:projeto_bd_front/views/widgets/edits/employee_edit.dart';

///
///
///
class DepartmentList extends StatefulWidget {
  ///
  ///
  ///
  const DepartmentList({super.key});

  ///
  ///
  ///
  @override
  State<DepartmentList> createState() => _DepartmentListState();
}

///
///
///
class _DepartmentListState extends State<DepartmentList> {
  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departamentos'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute<DepartmentEdit>(
                  builder:
                      (final BuildContext context) => const DepartmentEdit(),
                ),
              );

              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Department>?>(
        future: DepartmentConsumer().getAll(),
        builder: (
          final BuildContext context,
          final AsyncSnapshot<List<Department>?> snapshot,
        ) {
          if (snapshot.hasData) {
            final List<Department>? departments = snapshot.data;

            if (departments != null && departments.isNotEmpty) {
              return ListView.builder(
                itemCount: departments.length,
                itemBuilder: (final BuildContext context, final int index) {
                  final Department department = departments[index];
                  return ListTile(
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute<DepartmentEdit>(
                          builder: (final BuildContext context) =>
                              DepartmentEdit(model: department),
                        ),
                      ).then((_){
                        setState(() {});
                      });
                    },
                    title: Text(department.name),
                    leading: const Icon(Icons.business),
                  );
                },
              );
            } else {
              return const Center(child: Text('Sem departamentos cadastrados'));
            }
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
