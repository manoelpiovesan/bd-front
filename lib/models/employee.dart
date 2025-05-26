///
///
///
class Employee {
  int id = 0;
  int? departmentId;
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
    departmentId = json['departmentId'];
  }

  ///
  ///
  ///
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'departmentId': departmentId,
  };
}
