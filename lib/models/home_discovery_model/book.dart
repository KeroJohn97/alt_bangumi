import 'dart:convert';

import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String? cover;
  final String? title;
  final String? subjectId;
  final String? info;

  const Book({this.cover, this.title, this.subjectId, this.info});

  factory Book.fromMap(Map<String, dynamic> data) => Book(
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
  /// Parses the string and returns the resulting Json object as [Book].
  factory Book.fromJson(String data) {
    return Book.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Book] to a JSON string.
  String toJson() => json.encode(toMap());

  Book copyWith({
    String? cover,
    String? title,
    String? subjectId,
    String? info,
  }) {
    return Book(
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
