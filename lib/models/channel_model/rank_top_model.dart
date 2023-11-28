import 'dart:convert';

import 'package:equatable/equatable.dart';

class RankTopModel extends Equatable {
  final String? id;
  final String? name;
  final String? cover;
  final String? follow;

  const RankTopModel({this.id, this.name, this.cover, this.follow});

  factory RankTopModel.fromMap(Map<String, dynamic> data) => RankTopModel(
        id: data['id'] as String?,
        name: data['name'] as String?,
        cover: data['cover'] as String?,
        follow: data['follow'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'cover': cover,
        'follow': follow,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RankTopModel].
  factory RankTopModel.fromJson(String data) {
    return RankTopModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RankTopModel] to a JSON string.
  String toJson() => json.encode(toMap());

  RankTopModel copyWith({
    String? id,
    String? name,
    String? cover,
    String? follow,
  }) {
    return RankTopModel(
      id: id ?? this.id,
      name: name ?? this.name,
      cover: cover ?? this.cover,
      follow: follow ?? this.follow,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, cover, follow];
}
