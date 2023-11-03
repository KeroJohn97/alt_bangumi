import 'package:equatable/equatable.dart';

class StaticHentaiModel extends Equatable {
  final List<String>? tags;
  final List<Data>? data;

  const StaticHentaiModel({this.tags, this.data});

  factory StaticHentaiModel.fromJson(Map<String, dynamic> json) {
    return StaticHentaiModel(
      tags: (json['tags'] ?? []).map((e) => e.toString()),
      data: (json['data'] ?? []).map((e) => Data.fromJson(e)),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tags'] = tags;
    data['data'] = this.data?.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  List<Object?> get props => [tags, data];
}

class Data {
  final int? id;
  final int? h;
  final String? c;
  final String? j;
  final String? i;
  final double? s;
  final int? r;
  final int? n;
  final String? a;
  final int? e;
  final List<int>? t;

  Data(
      {this.id,
      this.h,
      this.c,
      this.j,
      this.i,
      this.s,
      this.r,
      this.n,
      this.a,
      this.e,
      this.t});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      h: json['h'],
      c: json['c'],
      j: json['j'],
      i: json['i'],
      s: json['s'],
      r: json['r'],
      n: json['n'],
      a: json['a'],
      e: json['e'],
      t: json['t'].cast<int>(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['h'] = h;
    data['c'] = c;
    data['j'] = j;
    data['i'] = i;
    data['s'] = s;
    data['r'] = r;
    data['n'] = n;
    data['a'] = a;
    data['e'] = e;
    data['t'] = t;
    return data;
  }
}
