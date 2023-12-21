import 'dart:convert';

import 'package:equatable/equatable.dart';

class TagModel extends Equatable {
  final String? name;
  final int? count;

  const TagModel({
    this.name,
    this.count,
  });

  factory TagModel.fromMap(Map<String, dynamic> data) => TagModel(
        name: data['name'] as String?,
        count: data['count'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'count': count,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TagModel].
  factory TagModel.fromJson(String data) {
    return TagModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TagModel] to a JSON string.
  String toJson() => json.encode(toMap());

  TagModel copyWith({
    String? name,
    int? count,
  }) {
    return TagModel(
      name: name ?? this.name,
      count: count ?? this.count,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, count];
}
