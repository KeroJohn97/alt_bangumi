import 'dart:convert';

import 'package:equatable/equatable.dart';

class RankModel extends Equatable {
  final String? id;
  final String? name;
  final String? cover;
  final String? follow;

  const RankModel({this.id, this.name, this.cover, this.follow});

  factory RankModel.fromMap(Map<String, dynamic> data) => RankModel(
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
  /// Parses the string and returns the resulting Json object as [RankModel].
  factory RankModel.fromJson(String data) {
    return RankModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RankModel] to a JSON string.
  String toJson() => json.encode(toMap());

  RankModel copyWith({
    String? id,
    String? name,
    String? cover,
    String? follow,
  }) {
    return RankModel(
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
