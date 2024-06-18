import 'dart:convert';
import 'dart:developer';

import 'package:alt_bangumi/constants/http_constant.dart';
import 'package:alt_bangumi/helpers/secret_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  HttpHelper._();

  static Future<dynamic> get(String endpoint,
      {Map<String, String>? headers}) async {
    final accessToken = (await secretHelper).authorization;
    headers?.addEntries({
      'Authorization': accessToken,
    } as Iterable<MapEntry<String, String>>);
    headers ??= {'Authorization': '$accessToken'};
    final url = Uri.parse(endpoint);
    log('GET ${endpoint.hashCode}: $url');
    final response = await http.get(url, headers: headers);
    log('GET RESPONSE ${endpoint.hashCode}: ${response.body}');
    try {
      final decodedJson = jsonDecode(response.body);
      return decodedJson;
    } on FormatException {
      return response.body;
    }
  }

  static Future<dynamic> post(String endpoint,
      {Map<String, String>? headers, dynamic data}) async {
    final accessToken = (await secretHelper).authorization;
    headers?.addEntries({
      'Authorization': accessToken,
    } as Iterable<MapEntry<String, String>>);
    final url = Uri.parse(endpoint);
    log('POST ${endpoint.hashCode}: $url');
    final response = await http.post(url, headers: headers, body: data);
    log('POST RESPONSE ${endpoint.hashCode}: ${response.body}');
    try {
      final decodedJson = jsonDecode(response.body);
      return decodedJson;
    } on FormatException {
      return response.body;
    }
  }

  static Future<dynamic> translate({
    required Locale locale,
    required String body,
  }) async {
    final secrets = await secretHelper;
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-RapidAPI-Key': '${secrets.rapidAPIKey}',
      'X-RapidAPI-Host': '${secrets.rapidAPIHost}',
    };
    final url = Uri.parse(
      'https://microsoft-translator-text.p.rapidapi.com/translate'
      '?api-version=3.0'
      '&to%5B0%5D=${locale.languageCode}'
      '&profanityAction=NoAction'
      '&textType=plain',
    );
    log('url: $url, headers: $headers, body: $body');
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    log('POST RESPONSE: ${response.body}');
    try {
      final decodedJson = jsonDecode(response.body);
      return decodedJson;
    } on FormatException {
      return response.body;
    }
  }

  static Future<String> getHtmlFromUrl(String url,
      {Map<String, String>? headers}) async {
    final accessToken = (await secretHelper).authorization;
    // final headers = {
    //   'Authorization': accessToken,
    // };
    // Make a GET request to the URL
    log('GET: $url');
    var response = await http.get(
      Uri.parse(url),
      headers: headers ??
          {
            'Authorization': '$accessToken',
            'Accept':
                'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3',
            'Accept-Encoding': 'gzip, deflate',
            'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
            'Connection': 'keep-alive',
            'Cache-Control': 'no-cache',
            'Pragma': 'no-cache',
            'Referer': HttpConstant.host,
          },
    );
    // Check if the request was successful
    if (response.statusCode == 200) {
      // Return the HTML string
      return response.body;
    } else {
      // Throw an exception if the request failed
      throw Exception('Failed to load HTML from $url');
    }
  }
}
