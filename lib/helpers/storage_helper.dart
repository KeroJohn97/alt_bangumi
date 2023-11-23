import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum StorageHelperOption {
  searchHistory, // List<String>
  searchResult, // List<SearchModel>
  subjectOption, // SearchScreenSubjectOption
}

class StorageHelper {
  StorageHelper._();

  static const _storage = FlutterSecureStorage();

  static final searchHistoryStream =
      StreamController<List<dynamic>>.broadcast();

  static Future<String?> read(StorageHelperOption option) async {
    return await _storage.read(key: option.name);
  }

  static Future<bool> write({
    required StorageHelperOption option,
    required String value,
  }) async {
    await _storage.write(key: option.name, value: value);
    final result = await _storage.read(key: option.name);
    return result == value;
  }

  static Future<bool> delete(StorageHelperOption option) async {
    await _storage.delete(key: option.name);
    final result = await _storage.read(key: option.name);
    return result == null;
  }

  static Future<bool> deleteAll() async {
    await _storage.deleteAll();
    final result = await _storage.readAll();
    return result.isEmpty;
  }
}
