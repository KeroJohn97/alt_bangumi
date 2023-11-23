import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'site_model.dart';

class EpModel extends Equatable {
  final int? id;
  final double? sort;
  final String? name;
  final List<SiteModel>? sites;

  const EpModel({this.id, this.sort, this.name, this.sites});

  factory EpModel.fromMap(Map<String, dynamic> data) => EpModel(
        id: data['id'] as int?,
        sort: (data['sort'] as num?)?.toDouble(),
        name: data['name'] as String?,
        sites: (data['sites'] as List<dynamic>?)
            ?.map((e) => SiteModel.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'sort': sort,
        'name': name,
        'sites': sites?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [EpModel].
  factory EpModel.fromJson(String data) {
    return EpModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [EpModel] to a JSON string.
  String toJson() => json.encode(toMap());

  EpModel copyWith({
    int? id,
    double? sort,
    String? name,
    List<SiteModel>? sites,
  }) {
    return EpModel(
      id: id ?? this.id,
      sort: sort ?? this.sort,
      name: name ?? this.name,
      sites: sites ?? this.sites,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, sort, name, sites];
}
