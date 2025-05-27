import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projeto_bd_front/models/dashboard.dart';
import 'package:projeto_bd_front/utils/config.dart';

///
///
///
class DashboardConsumer {
  ///
  ///
  ///
  Future<Dashboard?> getDashboard() async {
    final http.Response response = await http.get(
      Uri.parse('${Config.backUrl}/dashboard'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      return Dashboard.fromJson(decoded);
    }

    return null;
  }
}
