///
///
///
class Department {
  int id = 0;
  String name = '';

  ///
  ///
  ///
  Department();

  ///
  ///
  ///
  Department.fromJson(final Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
  }

  ///
  ///
  ///
  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'name': name};
}
