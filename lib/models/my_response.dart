import 'package:projeto_bd_front/models/abstract_model.dart';

class MyResponse<T extends AbstractModel> {
  List<T> data = <T>[];
  List<String> queries = <String>[];

  T get first =>
      data.isNotEmpty ? data.first : throw StateError('No data available');

  MyResponse.fromJson(
    final Map<String, dynamic> map,
    final T Function(Map<String, dynamic>) fromJson,
  ) {
    if (map['data'] != null) {
      for (final dynamic item in map['data']) {
        data.add(fromJson(item));
      }
    }
    if (map['queries'] != null) {
      queries = List<String>.from(map['queries']);
    }
  }
}
