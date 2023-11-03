import 'dart:convert';

import 'package:equatable/equatable.dart';

class Anime extends Equatable {
  final String? cover;
  final String? title;
  final String? subjectId;
  final String? info;

  const Anime({this.cover, this.title, this.subjectId, this.info});

  factory Anime.fromMap(Map<String, dynamic> data) => Anime(
        cover: data['cover'] as String?,
        title: data['title'] as String?,
        subjectId: data['subjectId'] as String?,
        info: data['info'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'cover': cover,
        'title': title,
        'subjectId': subjectId,
        'info': info,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Anime].
  factory Anime.fromJson(String data) {
    return Anime.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Anime] to a JSON string.
  String toJson() => json.encode(toMap());

  Anime copyWith({
    String? cover,
    String? title,
    String? subjectId,
    String? info,
  }) {
    return Anime(
      cover: cover ?? this.cover,
      title: title ?? this.title,
      subjectId: subjectId ?? this.subjectId,
      info: info ?? this.info,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [cover, title, subjectId, info];
}
