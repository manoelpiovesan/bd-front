import 'package:projeto_bd_front/models/dashboard/average_salary_by_department.dart';
import 'package:projeto_bd_front/models/dashboard/employees_by_department.dart';

///
///
///
class Dashboard {
  int totalEmployees = -1;
  int totalDepartments = -1;
  int unassignedEmployees = -1;
  List<EmployeesByDepartment> employeesByDepartment = <EmployeesByDepartment>[];
  List<AverageSalaryByDepartment> averageSalaryByDepartment =
      <AverageSalaryByDepartment>[];

  ///
  ///
  ///
  Dashboard();

  ///
  ///
  ///
  Dashboard.fromJson(final Map<String, dynamic> json) {
    totalEmployees = json['total_employees'] ?? -1;
    totalDepartments = json['total_departments'] ?? -1;
    unassignedEmployees = json['unassigned_employees'] ?? -1;

    if (json['employeesByDepartment'] != null) {
      final List<dynamic> departmentsJson = json['employeesByDepartment'];
      employeesByDepartment =
          departmentsJson
              .map(
                (final dynamic item) => EmployeesByDepartment.fromJson(
                  item as Map<String, dynamic>,
                ),
              )
              .toList();
    }

    if (json['averageSalaryByDepartment'] != null) {
      final List<dynamic> averageSalariesJson =
          json['averageSalaryByDepartment'];
      averageSalaryByDepartment =
          averageSalariesJson
              .map(
                (final dynamic item) => AverageSalaryByDepartment.fromJson(
                  item as Map<String, dynamic>,
                ),
              )
              .toList();
    }
  }

  ///
  ///
  ///
  Map<String, dynamic> toJson() => <String, dynamic>{
    'total_employees': totalEmployees,
    'total_departments': totalDepartments,
    'unassigned_employees': unassignedEmployees,
    'employeesByDepartment':
        employeesByDepartment
            .map((final EmployeesByDepartment item) => item.toJson())
            .toList(),

    'averageSalaryByDepartment':
        averageSalaryByDepartment
            .map((final AverageSalaryByDepartment item) => item.toJson())
            .toList(),
  };

  ///
  ///
  ///
  @override
  String toString() {
    return 'Dashboard{totalEmployees: $totalEmployees, totalDepartments:'
        ' $totalDepartments, unassignedEmployees: $unassignedEmployees, '
        'employeesByDepartment: $employeesByDepartment}';
  }
}
