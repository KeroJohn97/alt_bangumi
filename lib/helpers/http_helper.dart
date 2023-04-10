import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHelper {
  static Future<dynamic> get(String endpoint,
      {Map<String, String>? headers}) async {
    final url = Uri.parse(endpoint);
    final response = await http.get(url, headers: headers);
    try {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      return decodedJson;
    } on FormatException {
      return response.body;
    }
  }

  static Future<dynamic> post(String endpoint,
      {Map<String, String>? headers, dynamic data}) async {
    final url = Uri.parse(endpoint);
    final response = await http.post(url, headers: headers, body: data);
    try {
      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      return decodedJson;
    } on FormatException {
      return response.body;
    }
  }
}
