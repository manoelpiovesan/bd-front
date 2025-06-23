import 'package:projeto_bd_front/models/abstract_model.dart';
import 'package:projeto_bd_front/models/department.dart';

///
///
///
class Employee extends AbstractModel {
  int id = 0;
  Department? department;
  String name = '';
  int salary = 0;
  DateTime? dismissalDate;
  DateTime? admissionDate;

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
    dismissalDate =
        json['dismissalDate'] != null
            ? DateTime.parse(json['dismissalDate'] as String)
            : null;
    admissionDate =
        json['admissionDate'] != null
            ? DateTime.parse(json['admissionDate'] as String)
            : null;
    department =
        json['department'] != null
            ? Department.fromJson(json['department'] as Map<String, dynamic>)
            : null;
  }

  ///
  ///
  ///
  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'department': department?.toJson(),
    'salary': salary,
    'admissionDate': admissionDate != null 
        ? '${admissionDate!.year}-${admissionDate!.month.toString().padLeft(2, '0')}-${admissionDate!.day.toString().padLeft(2, '0')}'
        : null,
    'dismissalDate': dismissalDate != null 
        ? '${dismissalDate!.year}-${dismissalDate!.month.toString().padLeft(2, '0')}-${dismissalDate!.day.toString().padLeft(2, '0')}'
        : null,
  };

  ///
  ///
  ///
  @override
  String toString() {
    return 'Employee{id: $id, name: $name, department: ${department?.name}}';
  }
}
