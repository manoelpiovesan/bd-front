import 'package:flutter/material.dart';
import 'package:projeto_bd_front/consumers/department_consumer.dart';
import 'package:projeto_bd_front/consumers/employee_consumer.dart';
import 'package:projeto_bd_front/models/department.dart';
import 'package:projeto_bd_front/models/employee.dart';
import 'package:projeto_bd_front/models/my_response.dart';
import 'package:projeto_bd_front/views/widgets/my_button.dart';

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
  /// Converte string no formato "dd/MM/yyyy" para DateTime
  ///
  void _convertAndSetDate(String value, bool isAdmissionDate) {
    if (value.length == 10 && value.contains('/')) {
      try {
        final parts = value.split('/');
        if (parts.length == 3) {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          
          setState(() {
            if (isAdmissionDate) {
              model.admissionDate = DateTime(year, month, day);
            } else {
              model.dismissalDate = DateTime(year, month, day);
            }
          });
        }
      } catch (e) {
        // Data inválida, não faz nada
      }
    } else if (!isAdmissionDate && (value.isEmpty || value == 'Não Demitido')) {
      setState(() {
        model.dismissalDate = null;
      });
    }
  }

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

              /// Salary
              TextFormField(
                initialValue: model.salary.toString(),
                decoration: const InputDecoration(labelText: 'Salário'),
                keyboardType: TextInputType.number,
                onChanged: (final String value) {
                  setState(() {
                    model.salary = int.tryParse(value)!;
                  });
                },
              ),

              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      initialValue:
                          model.admissionDate == null
                              ? ''
                              : '${model.admissionDate!.day.toString().padLeft(2, '0')}'
                                  '/${model.admissionDate!.month.toString().padLeft(2, '0')}'
                                  '/${model.admissionDate!.year}',
                      decoration: const InputDecoration(
                        labelText: 'Data de Admissão',
                      ),
                      enabled: true,
                      onChanged: (final String value) {
                        _convertAndSetDate(value, true);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      initialValue:
                          model.dismissalDate == null
                              ? 'Não Demitido'
                              : '${model.dismissalDate!.day.toString().padLeft(2, '0')}'
                                  '/${model.dismissalDate!.month.toString().padLeft(2, '0')}'
                                  '/${model.dismissalDate!.year}',
                      decoration: const InputDecoration(
                        labelText: 'Data de Demissão',
                      ),
                      enabled: widget.model != null,
                      onChanged: (final String value) {
                        _convertAndSetDate(value, false);
                      },
                    ),
                  ),
                ],
              ),

              /// Department
              FutureBuilder<MyResponse<Department>?>(
                future: DepartmentConsumer().getAll(),
                builder: (
                  final BuildContext context,
                  final AsyncSnapshot<MyResponse<Department>?> snapshot,
                ) {
                  if (snapshot.hasData) {
                    final List<Department>? departments = snapshot.data?.data;

                    if (departments != null) {
                      final Department? selected =
                          model.department == null
                              ? null
                              : departments.firstWhere(
                                (final Department d) =>
                                    d.id == model.department?.id,
                                orElse: () => departments.first,
                              );

                      // Criar lista de itens incluindo "Sem Departamento"
                      final List<DropdownMenuItem<Department?>> items = [
                        const DropdownMenuItem<Department?>(
                          value: null,
                          child: Row(
                            spacing: 6,
                            children: <Widget>[
                              Icon(Icons.block, color: Colors.grey),
                              Text('Sem Departamento'),
                            ],
                          ),
                        ),
                        ...departments.map((final Department department) {
                          return DropdownMenuItem<Department?>(
                            value: department,
                            child: Row(
                              spacing: 6,
                              children: <Widget>[
                                const Icon(Icons.work, color: Colors.grey),
                                Text(department.name),
                              ],
                            ),
                          );
                        }),
                      ];

                      return DropdownButtonFormField<Department?>(
                        value: selected,
                        decoration: const InputDecoration(
                          labelText: 'Departamento',
                        ),
                        items: items,
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
              MyButton(
                label: widget.model != null ? 'Salvar' : 'Criar',
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
                iconData:
                    widget.model != null
                        ? Icons.save
                        : Icons.add_circle_outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
