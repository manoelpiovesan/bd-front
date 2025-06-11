import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_bd_front/models/department.dart';
import 'package:projeto_bd_front/models/my_response.dart';
import 'package:projeto_bd_front/utils/config.dart';
import 'package:projeto_bd_front/utils/utils.dart';

///
///
///
class DepartmentConsumer {
  ///
  ///
  ///
  Future<MyResponse<Department>?> getAll() async {
    final http.Response response = await http.get(
      Uri.parse('${Config.backUrl}/departments'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      return MyResponse<Department>.fromJson(decoded, Department.fromJson);
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

    return null;
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

  ///
  ///
  ///
  Future<void> delete(final int id) async {
    final http.Response response = await http.delete(
      Uri.parse('${Config.backUrl}/departments/$id'),
    );

    if (response.statusCode < 200 || response.statusCode > 299) {
      throw Exception('Falha ao excluir departamento');
    }
  }
}
