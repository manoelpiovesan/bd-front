import 'package:flutter/material.dart';
import 'package:projeto_bd_front/consumers/department_consumer.dart';
import 'package:projeto_bd_front/consumers/employee_consumer.dart';
import 'package:projeto_bd_front/models/department.dart';
import 'package:projeto_bd_front/models/employee.dart';

///
///
///
class EmployeeEdit extends StatefulWidget {
  final Employee? model;

  ///
  ///
  ///
  const EmployeeEdit({super.key, this.model});

  ///
  ///
  ///
  @override
  State<EmployeeEdit> createState() => _EmployeeEditState();
}

///
///
///
class _EmployeeEditState extends State<EmployeeEdit> {
  Employee model = Employee();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ///
  ///
  ///
  @override
  void initState() {
    if (widget.model != null) {
      model = widget.model!;
    }
    super.initState();
  }

  ///
  ///
  ///
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.model != null ? 'Editar Funcionário' : 'Criar Funcionário',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 12,
            children: <Widget>[
              /// Name
              TextFormField(
                initialValue: model.name,
                decoration: const InputDecoration(labelText: 'Nome'),
                onChanged: (final String value) {
                  setState(() {
                    model.name = value;
                  });
                },
              ),

              /// Department
              FutureBuilder<List<Department>?>(
                future: DepartmentConsumer().getAll(),
                builder: (
                  final BuildContext context,
                  final AsyncSnapshot<List<Department>?> snapshot,
                ) {
                  if (snapshot.hasData) {
                    final List<Department>? departments = snapshot.data;

                    if (departments != null && departments.isNotEmpty) {
                      final Department? selected =
                          model.department == null
                              ? null
                              : departments.firstWhere(
                                (final Department d) =>
                                    d.id == model.department?.id,
                                orElse: () => departments.first,
                              );

                      return DropdownButtonFormField<Department>(
                        value: selected,
                        decoration: const InputDecoration(
                          labelText: 'Departamento',
                        ),
                        items:
                            departments.map((final Department department) {
                              return DropdownMenuItem<Department>(
                                value: department,
                                child: Text(department.name),
                              );
                            }).toList(),
                        onChanged: (final Department? newValue) {
                          setState(() {
                            model.department = newValue;
                          });
                        },
                      );
                    } else {
                      return const Text('Nenhum departamento encontrado.');
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),

              /// Save or Update Button
              ElevatedButton.icon(
                label: Text(widget.model != null ? 'Salvar' : 'Criar'),
                onPressed: () {
                  /// On Update
                  if (widget.model != null) {
                    try {
                      EmployeeConsumer().update(model);
                      Navigator.of(context).pop();
                    } on Exception catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erro ao atualizar funcionário: $e'),
                        ),
                      );
                    }
                  }
                  /// On Create
                  else {
                    try {
                      EmployeeConsumer().create(model);
                      Navigator.of(context).pop();
                    } on Exception catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erro ao criar funcionário: $e'),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
