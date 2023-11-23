import 'dart:convert';

import 'package:equatable/equatable.dart';

class SiteModel extends Equatable {
  final String? site;
  final String? id;
  final int? sort;

  const SiteModel({this.site, this.id, this.sort});

  factory SiteModel.fromMap(Map<String, dynamic> data) => SiteModel(
        site: data['site'] as String?,
        id: data['id'] as String?,
        sort: data['sort'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'site': site,
        'id': id,
        'sort': sort,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SiteModel].
  factory SiteModel.fromJson(String data) {
    return SiteModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SiteModel] to a JSON string.
  String toJson() => json.encode(toMap());

  SiteModel copyWith({
    String? site,
    String? id,
    int? sort,
  }) {
    return SiteModel(
      site: site ?? this.site,
      id: id ?? this.id,
      sort: sort ?? this.sort,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [site, id, sort];
}
