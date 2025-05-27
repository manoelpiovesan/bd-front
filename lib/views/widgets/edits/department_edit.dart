import 'package:flutter/material.dart';
import 'package:projeto_bd_front/consumers/department_consumer.dart';
import 'package:projeto_bd_front/models/department.dart';

///
///
///
class DepartmentEdit extends StatefulWidget {
  final Department? model;

  ///
  ///
  ///
  const DepartmentEdit({super.key, this.model});

  ///
  ///
  ///
  @override
  State<DepartmentEdit> createState() => _DepartmentEditState();
}

///
///
///
class _DepartmentEditState extends State<DepartmentEdit> {
  Department model = Department();
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
          widget.model != null ? 'Editar Departamento' : 'Criar Departamento',
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

              // TODO(manoel): Implementar o future do departamento aqui.

              /// Save or Update Button
              ElevatedButton.icon(
                label: Text(widget.model != null ? 'Salvar' : 'Criar'),
                onPressed: () {
                  /// On Update
                  if (widget.model != null) {
                    try {
                      DepartmentConsumer().update(model);
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
                      DepartmentConsumer().create(model);
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
