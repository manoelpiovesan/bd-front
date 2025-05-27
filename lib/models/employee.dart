import 'package:projeto_bd_front/models/department.dart';

///
///
///
class Employee {
  int id = 0;
  Department? department;
  String name = '';
  int salary = 0;
  DateTime? dismissalDate;
  DateTime admissionDate = DateTime.now();

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
    salary = json['salary'] ?? 0;
    dismissalDate = json['dismissalDate'] != null
        ? DateTime.parse(json['dismissalDate'] as String)
        : null;
    admissionDate = json['admissionDate'] != null
        ? DateTime.parse(json['admissionDate'] as String)
        : DateTime.now();
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
    'salary': salary,
  };

  ///
  ///
  ///
  @override
  String toString() {
    return 'Employee{id: $id, name: $name, department: ${department?.name}}';
  }
}
