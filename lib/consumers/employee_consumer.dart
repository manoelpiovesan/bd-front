import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_bd_front/models/employee.dart';
import 'package:projeto_bd_front/utils/config.dart';
import 'package:projeto_bd_front/utils/utils.dart';

///
///
///
class EmployeeConsumer {
  ///
  ///
  ///
  Future<List<Employee>?> getAll({final String? term}) async {
    // Requesting
    final http.Response response = await http.get(
      Uri.parse('${Config.backUrl}/employees').replace(
        queryParameters: term != null ? <String, String>{'term': term} : null,
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      final List<Employee> employees =
          decoded
              .map(
                (final dynamic e) =>
                    Employee.fromJson(e as Map<String, dynamic>),
              )
              .toList();
      return employees;
    }

    return null;
  }

  ///
  ///
  ///
  Future<void> create(final Employee model) async {
    final http.Response response = await http.post(
      Uri.parse('${Config.backUrl}/employees'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(model.toJson()),
    );

    Utils().log(response);

    if (response.statusCode < 200 || response.statusCode > 299) {
      throw Exception('Falha ao criar funcionário');
    }
  }

  ///
  ///
  ///
  Future<void> update(final Employee model) async {
    final http.Response response = await http.put(
      Uri.parse('${Config.backUrl}/employees/${model.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(model.toJson()),
    );

    Utils().log(response);

    if (response.statusCode < 200 || response.statusCode > 299) {
      throw Exception('Falha ao atualizar funcionário');
    }
  }
}
