import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_bd_front/models/department.dart';
import 'package:projeto_bd_front/utils/config.dart';

///
///
///
class DepartmentConsumer {
  ///
  ///
  ///
  Future<List<Department>?> getAll() async {
    // Requesting
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
}
