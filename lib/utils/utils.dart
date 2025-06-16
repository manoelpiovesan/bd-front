import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

///
///
///
class Utils {
  ///
  ///
  ///
  void log(final http.Response response) {
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response headers: ${response.headers}');
    debugPrint('Response body: ${response.body}');
  }

  ///
  String tableFromListOfMaps(final List<Map<String, dynamic>> data) {
    if (data.isEmpty) {
      return '';
    }
    final List<String> headers = data.first.keys.toList();
    final StringBuffer buffer =
        StringBuffer()
          // Escreve o cabeçalho
          ..writeln(headers.join(' | '))
          ..writeln(
            headers.map((final String h) => '-' * h.length).join(' | '),
          );
    // Escreve as linhas
    for (final Map<String, dynamic> row in data) {
      buffer.writeln(
        headers.map((final String h) => row[h]?.toString() ?? '').join(' | '),
      );
    }
    return buffer.toString();
  }
}


