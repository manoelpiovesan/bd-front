import 'package:flutter/material.dart';
import 'package:projeto_bd_front/consumers/department_consumer.dart';
import 'package:projeto_bd_front/models/department.dart';
import 'package:projeto_bd_front/models/my_response.dart';
import 'package:projeto_bd_front/views/widgets/edits/department_edit.dart';

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
              await Navigator.of(context)
                  .push(
                    MaterialPageRoute<DepartmentEdit>(
                      builder:
                          (final BuildContext context) =>
                              const DepartmentEdit(),
                    ),
                  )
                  .then((_) {
                    setState(() {});
                  });

              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder<MyResponse<Department>?>(
        future: DepartmentConsumer().getAll(),
        builder: (
          final BuildContext context,
          final AsyncSnapshot<MyResponse<Department>?> snapshot,
        ) {
          if (snapshot.hasData) {
            final List<Department>? departments = snapshot.data?.data;

            if (departments != null && departments.isNotEmpty) {
              return ListView.builder(
                itemCount: departments.length,
                itemBuilder: (final BuildContext context, final int index) {
                  final Department department = departments[index];
                  return ListTile(
                    onTap: () async {
                      await Navigator.of(context)
                          .push(
                            MaterialPageRoute<DepartmentEdit>(
                              builder:
                                  (final BuildContext context) =>
                                      DepartmentEdit(model: department),
                            ),
                          )
                          .then((_) {
                            setState(() {});
                          });
                    },
                    title: Text(department.name),
                    leading: const Icon(Icons.work),
                    trailing: IconButton(
                      onPressed: () async {
                        await _delete(context, department).then((_) {
                          setState(() {});
                        });
                      },
                      icon: const Icon(Icons.delete, color: Colors.grey),
                    ),
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

  ///
  ///
  ///
  Future<void> _delete(
    final BuildContext context,
    final Department model,
  ) async {
    final Department? department = await showDialog<Department>(
      context: context,
      builder: (final BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir Departamento'),
          content: const Text(
            'Você tem certeza que deseja excluir este departamento?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                DepartmentConsumer().delete(model.id);
                Navigator.of(context).pop();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (department != null) {
      await DepartmentConsumer().delete(department.id);
      setState(() {});
    }
  }
}
