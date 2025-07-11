import 'package:projeto_bd_front/models/abstract_model.dart';

class AverageSalaryByDepartment extends AbstractModel {
  String name = '';
  double avgSalary = -1;

  ///
  ///
  ///
  AverageSalaryByDepartment();

  ///
  ///
  ///
  AverageSalaryByDepartment.fromJson(final Map<String, dynamic> json)
    : name = json['name'] ?? '',
      avgSalary = double.parse(json['average_salary']?.toString() ?? '-1');

  ///
  ///
  ///
  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'name': name, 'average_salary': avgSalary};
  }
}
