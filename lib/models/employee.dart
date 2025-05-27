import 'package:projeto_bd_front/models/department.dart';

///
///
///
class Employee {
  int id = 0;
  Department? department;
  String name = '';

  ///
  ///
  ///
  Employee();

  ///
  ///
  ///
  Employee.fromJson(final Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    department =
        json['department'] != null
            ? Department.fromJson(json['department'] as Map<String, dynamic>)
            : null;
  }

  ///
  ///
  ///
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'department': department?.toJson(),
  };

  ///
  ///
  ///
  @override
  String toString() {
    return 'Employee{id: $id, name: $name, department: ${department?.name}}';
  }
}
