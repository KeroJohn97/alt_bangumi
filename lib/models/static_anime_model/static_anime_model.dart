import 'dart:convert';

import 'package:equatable/equatable.dart';

class StaticAnimeModel extends Equatable {
  final int? id;
  final int? a;
  final String? o;
  final String? t;
  final String? e;
  final String? c;
  final String? j;
  final String? i;
  final String? b;
  final double? s;
  final int? r;

  const StaticAnimeModel({
    this.id,
    this.a,
    this.o,
    this.t,
    this.e,
    this.c,
    this.j,
    this.i,
    this.b,
    this.s,
    this.r,
  });

  factory StaticAnimeModel.fromMap(Map<String, dynamic> data) {
    return StaticAnimeModel(
      id: data['id'] as int?,
      a: data['a'] as int?,
      o: data['o'] as String?,
      t: data['t'] as String?,
      e: data['e'] as String?,
      c: data['c'] as String?,
      j: data['j'] as String?,
      i: data['i'] as String?,
      b: data['b'] as String?,
      s: (data['s'] as num?)?.toDouble(),
      r: data['r'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'a': a,
        'o': o,
        't': t,
        'e': e,
        'c': c,
        'j': j,
        'i': i,
        'b': b,
        's': s,
        'r': r,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [StaticAnimeModel].
  factory StaticAnimeModel.fromJson(String data) {
    return StaticAnimeModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [StaticAnimeModel] to a JSON string.
  String toJson() => json.encode(toMap());

  StaticAnimeModel copyWith({
    int? id,
    int? a,
    String? o,
    String? t,
    String? e,
    String? c,
    String? j,
    String? i,
    String? b,
    double? s,
    int? r,
  }) {
    return StaticAnimeModel(
      id: id ?? this.id,
      a: a ?? this.a,
      o: o ?? this.o,
      t: t ?? this.t,
      e: e ?? this.e,
      c: c ?? this.c,
      j: j ?? this.j,
      i: i ?? this.i,
      b: b ?? this.b,
      s: s ?? this.s,
      r: r ?? this.r,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, a, o, t, e, c, j, i, b, s, r];
}
