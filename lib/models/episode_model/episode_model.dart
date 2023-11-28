import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'datum_model.dart';

class EpisodeModel extends Equatable {
  final List<DatumModel>? data;
  final int? total;
  final int? limit;
  final int? offset;

  const EpisodeModel({this.data, this.total, this.limit, this.offset});

  factory EpisodeModel.fromMap(Map<String, dynamic> data) => EpisodeModel(
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => DatumModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        total: data['total'] as int?,
        limit: data['limit'] as int?,
        offset: data['offset'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'data': data?.map((e) => e.toMap()).toList(),
        'total': total,
        'limit': limit,
        'offset': offset,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [EpisodeModel].
  factory EpisodeModel.fromJson(String data) {
    return EpisodeModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [EpisodeModel] to a JSON string.
  String toJson() => json.encode(toMap());

  EpisodeModel copyWith({
    List<DatumModel>? data,
    int? total,
    int? limit,
    int? offset,
  }) {
    return EpisodeModel(
      data: data ?? this.data,
      total: total ?? this.total,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [data, total, limit, offset];
}
