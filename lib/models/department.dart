import 'package:projeto_bd_front/models/abstract_model.dart';

///
///
///
class Department extends AbstractModel {
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
  @override
  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'name': name};


}
