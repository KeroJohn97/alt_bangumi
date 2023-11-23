import 'dart:convert';

import 'package:equatable/equatable.dart';

class CollectionModel extends Equatable {
  final int? wish;
  final int? collect;
  final int? doing;
  final int? onHold;
  final int? dropped;

  const CollectionModel({
    this.wish,
    this.collect,
    this.doing,
    this.onHold,
    this.dropped,
  });

  factory CollectionModel.fromMap(Map<String, dynamic> data) => CollectionModel(
        wish: data['wish'] as int?,
        collect: data['collect'] as int?,
        doing: data['doing'] as int?,
        onHold: data['on_hold'] as int?,
        dropped: data['dropped'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'wish': wish,
        'collect': collect,
        'doing': doing,
        'on_hold': onHold,
        'dropped': dropped,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CollectionModel].
  factory CollectionModel.fromJson(String data) {
    return CollectionModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CollectionModel] to a JSON string.
  String toJson() => json.encode(toMap());

  CollectionModel copyWith({
    int? wish,
    int? collect,
    int? doing,
    int? onHold,
    int? dropped,
  }) {
    return CollectionModel(
      wish: wish ?? this.wish,
      collect: collect ?? this.collect,
      doing: doing ?? this.doing,
      onHold: onHold ?? this.onHold,
      dropped: dropped ?? this.dropped,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [wish, collect, doing, onHold, dropped];
}
