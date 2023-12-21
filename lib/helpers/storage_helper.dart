import 'dart:async';

import 'package:alt_bangumi/constants/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
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
        return TextConstant.searchHistory.getString(context);
      case StorageHelperOption.searchResultHistory:
        return TextConstant.searchResultHistory.getString(context);
      case StorageHelperOption.defaultSearchSubjectOption:
        return TextConstant.defaultSearchSubjectOption.getString(context);
      case StorageHelperOption.homeAnimeList:
        return TextConstant.homeAnimeList.getString(context);
      case StorageHelperOption.translationHistory:
        return TextConstant.translationHistory.getString(context);
      case StorageHelperOption.subjectDetailList:
        return TextConstant.subjectDetailList.getString(context);
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
