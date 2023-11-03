import 'dart:convert';

import 'package:equatable/equatable.dart';

class StaticMangaModel extends Equatable {
  final int? id;
  final int? m;
  final int? st;
  final String? a;
  final String? t;
  final String? e;
  final String? c;
  final String? j;
  final String? i;
  final int? b;
  final double? s;
  final int? r;

  const StaticMangaModel({
    this.id,
    this.m,
    this.st,
    this.a,
    this.t,
    this.e,
    this.c,
    this.j,
    this.i,
    this.b,
    this.s,
    this.r,
  });

  factory StaticMangaModel.fromMap(Map<String, dynamic> data) {
    return StaticMangaModel(
      id: data['id'] as int?,
      m: data['m'] as int?,
      st: data['st'] as int?,
      a: data['a'] as String?,
      t: data['t'] as String?,
      e: data['e'] as String?,
      c: data['c'] as String?,
      j: data['j'] as String?,
      i: data['i'] as String?,
      b: data['b'] as int?,
      s: (data['s'] as num?)?.toDouble(),
      r: data['r'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'm': m,
        'st': st,
        'a': a,
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
  /// Parses the string and returns the resulting Json object as [StaticMangaModel].
  factory StaticMangaModel.fromJson(String data) {
    return StaticMangaModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [StaticMangaModel] to a JSON string.
  String toJson() => json.encode(toMap());

  StaticMangaModel copyWith({
    int? id,
    int? m,
    int? st,
    String? a,
    String? t,
    String? e,
    String? c,
    String? j,
    String? i,
    int? b,
    double? s,
    int? r,
  }) {
    return StaticMangaModel(
      id: id ?? this.id,
      m: m ?? this.m,
      st: st ?? this.st,
      a: a ?? this.a,
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
  List<Object?> get props => [id, m, st, a, t, e, c, j, i, b, s, r];
}
