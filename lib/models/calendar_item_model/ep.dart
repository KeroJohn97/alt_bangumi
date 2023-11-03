import 'dart:convert';

import 'package:equatable/equatable.dart';

class Ep extends Equatable {
  final int? type;
  final int? sort;
  final String? name;
  final String? airdate;

  const Ep({this.type, this.sort, this.name, this.airdate});

  factory Ep.fromMap(Map<String, dynamic> data) => Ep(
        type: data['type'] as int?,
        sort: data['sort'] as int?,
        name: data['name'] as String?,
        airdate: data['airdate'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'type': type,
        'sort': sort,
        'name': name,
        'airdate': airdate,
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
    int? type,
    int? sort,
    String? name,
    String? airdate,
  }) {
    return Ep(
      type: type ?? this.type,
      sort: sort ?? this.sort,
      name: name ?? this.name,
      airdate: airdate ?? this.airdate,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [type, sort, name, airdate];
}
