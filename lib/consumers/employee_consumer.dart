import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_bd_front/models/employee.dart';
import 'package:projeto_bd_front/models/my_response.dart';
import 'package:projeto_bd_front/utils/config.dart';
import 'package:projeto_bd_front/utils/utils.dart';

///
///
///
class EmployeeConsumer {
  ///
  ///
  ///
  Future<MyResponse<Employee>?> getAll({
    final String? term,
    final int? limit,
    final int? offset,
  }) async {
    // Requesting
    final http.Response response = await http.get(
      Uri.parse('${Config.backUrl}/employees').replace(
        queryParameters: <String, String>{
          if (term != null) 'term': term,
          if (limit != null) 'limit': limit.toString(),
          if (offset != null) 'offset': offset.toString(),
        },
      ),
    );

    Utils().log(response);

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      return MyResponse<Employee>.fromJson(decoded, Employee.fromJson);
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

  ///
  ///
  ///
  Future<void> delete(final int id) async {
    final http.Response response = await http.delete(
      Uri.parse('${Config.backUrl}/employees/$id'),
    );

    if (response.statusCode < 200 || response.statusCode > 299) {
      throw Exception('Falha ao excluir funcionário');
    }
  }
}
