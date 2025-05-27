import 'package:flutter/material.dart';
import 'package:projeto_bd_front/consumers/employee_consumer.dart';
import 'package:projeto_bd_front/models/employee.dart';
import 'package:projeto_bd_front/views/widgets/edits/employee_edit.dart';

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
  final TextEditingController _termController = TextEditingController();

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionários'),
        actions: <Widget>[
          /// Add
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await _addEmployee().then((_) {
                setState(() {});
              });
            },
          ),

          /// Refresh
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          /// Search
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _termController,
              decoration: InputDecoration(
                labelText: 'Pesquisar',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (final String value) {
                setState(() {});
              },
            ),
          ),

          /// List
          Expanded(
            child: FutureBuilder<List<Employee>?>(
              future: EmployeeConsumer().getAll(term: _termController.text),
              builder: (
                final BuildContext context,
                final AsyncSnapshot<List<Employee>?> snapshot,
              ) {
                if (snapshot.hasData) {
                  final List<Employee>? employees = snapshot.data;

                  if (employees != null && employees.isNotEmpty) {
                    return ListView.builder(
                      itemCount: employees.length,
                      itemBuilder: (
                        final BuildContext context,
                        final int index,
                      ) {
                        final Employee employee = employees[index];
                        return ListTile(
                          onTap: () async {
                            await Navigator.of(context)
                                .push(
                                  MaterialPageRoute<EmployeeEdit>(
                                    builder:
                                        (final BuildContext context) =>
                                            EmployeeEdit(model: employee),
                                  ),
                                )
                                .then((_) {
                                  setState(() {});
                                });
                          },
                          title: Text(employee.name),
                          leading: const Icon(Icons.person),
                          subtitle: Text(
                            employee.department?.name ?? 'Sem departamento',
                          ),
                          trailing: IconButton(
                            onPressed: () async {
                              await _deleteEmployee(context, employee).then((
                                _,
                              ) {
                                setState(() {});
                              });
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Sem funcionários cadastrados'),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///
  ///
  Future<void> _addEmployee() async {
    await Navigator.of(context)
        .push(
          MaterialPageRoute<EmployeeEdit>(
            builder: (final BuildContext context) => const EmployeeEdit(),
          ),
        )
        .then((_) {
          setState(() {});
        });
  }

  ///
  ///
  ///
  Future<void> _deleteEmployee(
    final BuildContext context,
    final Employee model,
  ) async {
    final Employee? employee = await showDialog<Employee>(
      context: context,
      builder: (final BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir Funcionário'),
          content: const Text(
            'Você tem certeza que deseja excluir este funcionário?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                EmployeeConsumer().delete(model.id);
                Navigator.of(context).pop();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );

    if (employee != null) {
      try {
        await EmployeeConsumer().delete(employee.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Funcionário excluído com sucesso')),
        );
        setState(() {});
      } on Exception catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao excluir funcionário: $e')),
        );
      }
    }
  }
}
