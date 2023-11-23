import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'search_info.dart';

class SearchModel extends Equatable {
  final int? results;
  final List<SearchInfo>? searchList;
  final String? keyword;

  const SearchModel({this.results, this.searchList, this.keyword});

  factory SearchModel.fromMap(Map<String, dynamic> data) => SearchModel(
        results: data['results'] as int?,
        searchList: (data['list'] as List<dynamic>?)
            ?.map((e) => SearchInfo.fromMap(e))
            .toList(),
        keyword: data['keyword'],
      );

  Map<String, dynamic> toMap() => {
        'results': results,
        'list': searchList?.map((e) => e.toMap()).toList(),
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
    List<SearchInfo>? searchList,
    String? keyword,
  }) {
    return SearchModel(
      results: results ?? this.results,
      searchList: searchList ?? this.searchList,
      keyword: keyword ?? this.keyword,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [results, searchList, keyword];
}
