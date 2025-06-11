import 'package:projeto_bd_front/models/abstract_model.dart';

///
///
///
class CommonStats extends AbstractModel {
  int totalEmployees = -1;
  int totalDepartments = -1;
  int unassignedEmployees = -1;
  double averageSalary = -1;
  int highestSalary = -1;
  int lowestSalary = -1;
  int newHiresLast30Days = -1;
  int activeDepartments = -1;

  ///
  ///
  ///
  CommonStats();

  ///
  ///
  ///
  CommonStats.fromJson(final Map<String, dynamic> json) {
    totalEmployees = json['totalEmployees'] ?? -1;
    totalDepartments = json['totalDepartments'] ?? -1;
    unassignedEmployees = json['unassignedEmployees'] ?? -1;
    averageSalary = double.parse(json['averageSalary']?.toString() ?? '-1');
    highestSalary = json['highestSalary'] ?? -1;
    lowestSalary = json['lowestSalary'] ?? -1;
    newHiresLast30Days = json['newHiresLast30Days'] ?? -1;
    activeDepartments = json['activeDepartments'] ?? -1;
  }

  ///
  ///
  ///
  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'totalEmployees': totalEmployees,
    'totalDepartments': totalDepartments,
    'unassignedEmployees': unassignedEmployees,
    'averageSalary': averageSalary,
    'highestSalary': highestSalary,
    'lowestSalary': lowestSalary,
    'newHiresLast30Days': newHiresLast30Days,
    'activeDepartments': activeDepartments,
  };

  ///
  ///
  ///
  @override
  String toString() {
    return 'Dashboard{totalEmployees: $totalEmployees, totalDepartments: '
        '$totalDepartments, unassignedEmployees: $unassignedEmployees}';
  }
}
