import 'dart:convert';
import 'package:flutter/services.dart';

class SecretHelper {
  final String authorization;
  SecretHelper({
    required this.authorization,
  });

  factory SecretHelper.fromJson(Map<String, dynamic> jsonMap) {
    return SecretHelper(
      authorization: jsonMap['Authorization'],
    );
  }
}

class SecretLoader {
  final String secretPath;
  SecretLoader({required this.secretPath});
  Future<SecretHelper> load() {
    return rootBundle.loadStructuredData<SecretHelper>(secretPath,
        (jsonStr) async {
      final secret = SecretHelper.fromJson(json.decode(jsonStr));
      return secret;
    });
  }
}

Future<SecretHelper> secretHelper =
    SecretLoader(secretPath: "secret.json").load();
