import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_bd_front/utils/config.dart';

class PlaygroundConsumer {
  ///
  ///
  ///
  Future<List<Map<String, dynamic>>?> executeQuery(final String? query) async {
    final http.Response response = await http.post(
      Uri.parse('${Config.backUrl}/playground'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'query': query ?? ''}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);

      return List<Map<String, dynamic>>.from(decoded['data'] as List<dynamic>);
    }

    return null;
  }
}
