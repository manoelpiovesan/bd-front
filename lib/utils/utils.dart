import 'package:flutter/cupertino.dart';
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
}
