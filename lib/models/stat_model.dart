import 'dart:convert';

import 'package:equatable/equatable.dart';

class StatModel extends Equatable {
  final int? comments;
  final int? collects;

  const StatModel({this.comments, this.collects});

  factory StatModel.fromMap(Map<String, dynamic> data) => StatModel(
        comments: data['comments'] as int?,
        collects: data['collects'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'comments': comments,
        'collects': collects,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [StatModel].
  factory StatModel.fromJson(String data) {
    return StatModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [StatModel] to a JSON string.
  String toJson() => json.encode(toMap());

  StatModel copyWith({
    int? comments,
    int? collects,
  }) {
    return StatModel(
      comments: comments ?? this.comments,
      collects: collects ?? this.collects,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [comments, collects];
}
