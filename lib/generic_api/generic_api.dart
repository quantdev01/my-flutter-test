
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:my_flutter_test/utils/constants.dart';

Future<Map<String, String>> headers() async {
  return {'Content-Type': 'application/json'};
}

class GenericApi {
  final http.Client client;
  GenericApi({required this.client});

  Future<T> fetchData<T>(String url, T Function(Json json) fromJson) async {
    log('Fetching data from $url');
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: await headers(),
      );
      log('Response status: ${response.statusCode}');
      return fromJson(jsonDecode(response.body));
    } catch (e, stackTrace) {
      log(
        'Error while fetching data : error [$e], stacktrace [$stackTrace]',
      );
      return fromJson({});
    }
  }

  Future<List<T>> fetchListData<T>(
    String url,
    T Function(Json json) fromJson,
  ) async {
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: await headers(),
      );
      log('Data gotten ${response.body.length}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body) as List;
        return decoded.map((e) => fromJson(e)).toList();
      }
      log('Data gotten ${response.body}');
      log('Error while fetching list of data : error');
      return [];
    } catch (e, stackTrace) {
     log(
        'Error while fetching list of data : error [$e], stacktrace [$stackTrace]',
      );
      return [];
    }
  }

}
