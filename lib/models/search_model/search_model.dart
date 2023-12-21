import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'search_info_model.dart';

class SearchModel extends Equatable {
  final int? results;
  final List<SearchInfoModel>? searchInfoList;
  final String? keyword;

  const SearchModel({this.results, this.searchInfoList, this.keyword});

  factory SearchModel.fromMap(Map<String, dynamic> data) => SearchModel(
        results: data['results'] as int?,
        searchInfoList: (data['list'] as List<dynamic>?)
            ?.map((e) => SearchInfoModel.fromMap(e))
            .toList(),
        keyword: data['keyword'],
      );

  Map<String, dynamic> toMap() => {
        'results': results,
        'list': searchInfoList?.map((e) => e.toMap()).toList(),
        'keyword': keyword,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SearchModel].
  factory SearchModel.fromJson(String data) {
    return SearchModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SearchModel] to a JSON string.
  String toJson() => json.encode(toMap());

  SearchModel copyWith({
    int? results,
    List<SearchInfoModel>? searchInfoList,
    String? keyword,
  }) {
    return SearchModel(
      results: results ?? this.results,
      searchInfoList: searchInfoList ?? this.searchInfoList,
      keyword: keyword ?? this.keyword,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [results, searchInfoList, keyword];
}
