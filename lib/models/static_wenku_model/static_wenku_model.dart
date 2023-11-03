import 'dart:convert';

import 'package:equatable/equatable.dart';

class StaticWenkuModel extends Equatable {
  final int? id;
  final int? w;
  final int? an;
  final String? a;
  final String? e;
  final String? c;
  final String? j;
  final String? i;
  final String? b;
  final String? up;
  final String? ca;
  final int? h;
  final int? u;
  final int? l;
  final double? s;
  final int? r;

  const StaticWenkuModel({
    this.id,
    this.w,
    this.an,
    this.a,
    this.e,
    this.c,
    this.j,
    this.i,
    this.b,
    this.up,
    this.ca,
    this.h,
    this.u,
    this.l,
    this.s,
    this.r,
  });

  factory StaticWenkuModel.fromMap(Map<String, dynamic> data) {
    return StaticWenkuModel(
      id: data['id'] as int?,
      w: data['w'] as int?,
      an: data['an'] as int?,
      a: data['a'] as String?,
      e: data['e'] as String?,
      c: data['c'] as String?,
      j: data['j'] as String?,
      i: data['i'] as String?,
      b: data['b'] as String?,
      up: data['up'] as String?,
      ca: data['ca'] as String?,
      h: data['h'] as int?,
      u: data['u'] as int?,
      l: data['l'] as int?,
      s: (data['s'] as num?)?.toDouble(),
      r: data['r'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'w': w,
        'an': an,
        'a': a,
        'e': e,
        'c': c,
        'j': j,
        'i': i,
        'b': b,
        'up': up,
        'ca': ca,
        'h': h,
        'u': u,
        'l': l,
        's': s,
        'r': r,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [StaticWenkuModel].
  factory StaticWenkuModel.fromJson(String data) {
    return StaticWenkuModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [StaticWenkuModel] to a JSON string.
  String toJson() => json.encode(toMap());

  StaticWenkuModel copyWith({
    int? id,
    int? w,
    int? an,
    String? a,
    String? e,
    String? c,
    String? j,
    String? i,
    String? b,
    String? up,
    String? ca,
    int? h,
    int? u,
    int? l,
    double? s,
    int? r,
  }) {
    return StaticWenkuModel(
      id: id ?? this.id,
      w: w ?? this.w,
      an: an ?? this.an,
      a: a ?? this.a,
      e: e ?? this.e,
      c: c ?? this.c,
      j: j ?? this.j,
      i: i ?? this.i,
      b: b ?? this.b,
      up: up ?? this.up,
      ca: ca ?? this.ca,
      h: h ?? this.h,
      u: u ?? this.u,
      l: l ?? this.l,
      s: s ?? this.s,
      r: r ?? this.r,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      w,
      an,
      a,
      e,
      c,
      j,
      i,
      b,
      up,
      ca,
      h,
      u,
      l,
      s,
      r,
    ];
  }
}
