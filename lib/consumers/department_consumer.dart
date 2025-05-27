import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_bd_front/models/department.dart';
import 'package:projeto_bd_front/utils/config.dart';
import 'package:projeto_bd_front/utils/utils.dart';

///
///
///
class DepartmentConsumer {
  ///
  ///
  ///
  Future<List<Department>?> getAll() async {
    final http.Response response = await http.get(
      Uri.parse('${Config.backUrl}/departments'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      final List<Department> employees =
          decoded
              .map(
                (final dynamic e) =>
                    Department.fromJson(e as Map<String, dynamic>),
              )
              .toList();
      return employees;
    }

    return null;
  }

  ///
  ///
  ///
  Future<void> create(final Department model) async {
    final http.Response response = await http.post(
      Uri.parse('${Config.backUrl}/departments'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(model.toJson()),
    );

    Utils().log(response);

    if (response.statusCode < 200 || response.statusCode > 299) {
      throw Exception('Falha ao criar departamento');
    }
  }

  ///
  ///
  ///
  Future<void> update(final Department model) async {
    final http.Response response = await http.put(
      Uri.parse('${Config.backUrl}/departments/${model.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(model.toJson()),
    );

    Utils().log(response);

    if (response.statusCode < 200 || response.statusCode > 299) {
      throw Exception('Falha ao atualizar departamento');
    }
  }
}
