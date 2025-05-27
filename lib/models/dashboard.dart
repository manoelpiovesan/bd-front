///
///
///
class Dashboard {
  int totalEmployees = -1;
  int totalDepartments = -1;
  int unassignedEmployees = -1;
  List<DashboardDepartment> employeesByDepartment = <DashboardDepartment>[];

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
                (final dynamic item) =>
                    DashboardDepartment.fromJson(item as Map<String, dynamic>),
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
            .map((final DashboardDepartment item) => item.toJson())
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

///
///
///
class DashboardDepartment {
  int id = -1;
  String name = '';
  int totalEmployees = -1;

  ///
  ///
  ///
  DashboardDepartment();

  ///
  ///
  ///
  DashboardDepartment.fromJson(final Map<String, dynamic> json) {
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
