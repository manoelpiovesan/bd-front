import 'package:flutter/material.dart';
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
    return Form(
      key: formKey,
      child: Column(
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

            },
          ),
        ],
      ),
    );
  }
}
