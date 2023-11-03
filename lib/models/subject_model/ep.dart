import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'site.dart';

class Ep extends Equatable {
  final int? id;
  final double? sort;
  final String? name;
  final List<Site>? sites;

  const Ep({this.id, this.sort, this.name, this.sites});

  factory Ep.fromMap(Map<String, dynamic> data) => Ep(
        id: data['id'] as int?,
        sort: (data['sort'] as num?)?.toDouble(),
        name: data['name'] as String?,
        sites: (data['sites'] as List<dynamic>?)
            ?.map((e) => Site.fromMap(e as Map<String, dynamic>))
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
  /// Parses the string and returns the resulting Json object as [Ep].
  factory Ep.fromJson(String data) {
    return Ep.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Ep] to a JSON string.
  String toJson() => json.encode(toMap());

  Ep copyWith({
    int? id,
    double? sort,
    String? name,
    List<Site>? sites,
  }) {
    return Ep(
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
