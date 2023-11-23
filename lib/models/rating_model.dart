import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'count_model.dart';

class RatingModel extends Equatable {
  final int? rank;
  final int? total;
  final CountModel? count;
  final double? score;

  const RatingModel({this.rank, this.total, this.count, this.score});

  factory RatingModel.fromMap(Map<String, dynamic> data) => RatingModel(
        rank: data['rank'] as int?,
        total: data['total'] as int?,
        count: data['count'] == null
            ? null
            : CountModel.fromMap(data['count'] as Map<String, dynamic>),
        score: (data['score'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'rank': rank,
        'total': total,
        'count': count?.toMap(),
        'score': score,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RatingModel].
  factory RatingModel.fromJson(String data) {
    return RatingModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RatingModel] to a JSON string.
  String toJson() => json.encode(toMap());

  RatingModel copyWith({
    int? rank,
    int? total,
    CountModel? count,
    double? score,
  }) {
    return RatingModel(
      rank: rank ?? this.rank,
      total: total ?? this.total,
      count: count ?? this.count,
      score: score ?? this.score,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [rank, total, count, score];
}
