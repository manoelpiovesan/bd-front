import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_bd_front/models/dashboard/average_salary_by_department.dart';
import 'package:projeto_bd_front/models/dashboard/common_stats.dart';
import 'package:projeto_bd_front/models/dashboard/employees_by_department.dart';
import 'package:projeto_bd_front/models/my_response.dart';
import 'package:projeto_bd_front/utils/config.dart';

///
///
///
class DashboardConsumer {
  ///
  ///
  ///
  Future<MyResponse<CommonStats>?> getCommonStats() async {
    final http.Response response = await http.get(
      Uri.parse('${Config.backUrl}/dashboard/common-stats'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      return MyResponse<CommonStats>.fromJson(decoded, CommonStats.fromJson);
    }

    return null;
  }

  ///
  ///
  ///
  Future<MyResponse<AverageSalaryByDepartment>?>
  getAverageSalaryByDepartment() async {
    final http.Response response = await http.get(
      Uri.parse('${Config.backUrl}/dashboard/average-salary-by-department'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      return MyResponse<AverageSalaryByDepartment>.fromJson(
        decoded,
        AverageSalaryByDepartment.fromJson,
      );
    }

    return null;
  }

  ///
  ///
  ///
  Future<MyResponse<EmployeesByDepartment>?> getEmployeesByDepartment() async {
    final http.Response response = await http.get(
      Uri.parse('${Config.backUrl}/dashboard/employees-by-department'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      return MyResponse<EmployeesByDepartment>.fromJson(
        decoded,
        EmployeesByDepartment.fromJson,
      );
    }

    return null;
  }
}
