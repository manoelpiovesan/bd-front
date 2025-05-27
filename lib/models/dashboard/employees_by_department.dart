///
///
///
class EmployeesByDepartment {
  int id = -1;
  String name = '';
  int totalEmployees = -1;

  ///
  ///
  ///
  EmployeesByDepartment();

  ///
  ///
  ///
  EmployeesByDepartment.fromJson(final Map<String, dynamic> json) {
    id = json['id'] ?? -1;
    name = json['name'] ?? '';
    totalEmployees = json['total_employees'] ?? -1;
  }

  ///
  ///
  ///
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'total_employees': totalEmployees,
  };

  ///
  ///
  ///
  @override
  String toString() {
    return 'DashboardDepartment{id: $id, name: $name, '
        'totalEmployees: $totalEmployees}';
  }
}