import 'dart:async';

import 'package:alt_bangumi/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum StorageHelperOption {
  searchHistory('List<String>'),
  searchResultHistory('Map<ScreenSubjectOption, Map<String, SearchModel>>'),
  defaultSearchSubjectOption('ScreenSubjectOption'),
  homeAnimeList('Map<ScreenSubjectOption, List<SubjectModel>>'),
  translationHistory('Map<String, Map<String, String>>'),
  subjectDetailList(
      'Map<String, Map<String, dynamic>> including SubjectModel, EpisodeModel, List<RelationModel> characters, relations, persons');

  final String datatype;

  const StorageHelperOption(this.datatype);
}

extension StorageHelperOptionExtension on StorageHelperOption {
  String getString(BuildContext context) {
    switch (this) {
      case StorageHelperOption.searchHistory:
        return context.t.searchHistory;
      case StorageHelperOption.searchResultHistory:
        return context.t.searchResultHistory;
      case StorageHelperOption.defaultSearchSubjectOption:
        return context.t.defaultSearchSubjectOption;
      case StorageHelperOption.homeAnimeList:
        return context.t.homeAnimeList;
      case StorageHelperOption.translationHistory:
        return context.t.translationHistory;
      case StorageHelperOption.subjectDetailList:
        return context.t.subjectDetailList;
    }
  }
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
