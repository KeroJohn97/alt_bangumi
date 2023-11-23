import 'dart:convert';

import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  final String? name;
  final int? count;

  const Tag({this.name, this.count});

  factory Tag.fromMap(Map<String, dynamic> data) => Tag(
        name: data['name'] as String?,
        count: data['count'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'count': count,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Tag].
  factory Tag.fromJson(String data) {
    return Tag.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Tag] to a JSON string.
  String toJson() => json.encode(toMap());

  Tag copyWith({
    String? name,
    int? count,
  }) {
    return Tag(
      name: name ?? this.name,
      count: count ?? this.count,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, count];
}
