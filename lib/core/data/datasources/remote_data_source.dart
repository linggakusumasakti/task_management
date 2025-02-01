import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_management/core/utils/constants.dart';

abstract class RemoteDataSource {
  Future<dynamic> login(String email, String password);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future login(String email, String password) async {
    final url = Uri.https(baseUrl, '/api/login');
    final response =
        await client.post(url, body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['token'];
    } else {
      throw FormatException(json.decode(response.body)['error']);
    }
  }
}
