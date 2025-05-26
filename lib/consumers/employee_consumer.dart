import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_bd_front/models/employee.dart';
import 'package:projeto_bd_front/utils/config.dart';

///
///
///
class EmployeeConsumer {
  ///
  ///
  ///
  Future<List<Employee>?> getAll() async {
    // Requesting
    final http.Response response = await http.get(
      Uri.parse('${Config.backUrl}/employees'),
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
}
