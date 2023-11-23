import 'dart:convert';

import 'package:equatable/equatable.dart';

class Weekday extends Equatable {
  final String? en;
  final String? cn;
  final String? ja;
  final int? id;

  const Weekday({this.en, this.cn, this.ja, this.id});

  factory Weekday.fromMap(Map<String, dynamic> data) => Weekday(
        en: data['en'] as String?,
        cn: data['cn'] as String?,
        ja: data['ja'] as String?,
        id: data['id'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'en': en,
        'cn': cn,
        'ja': ja,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Weekday].
  factory Weekday.fromJson(String data) {
    return Weekday.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Weekday] to a JSON string.
  String toJson() => json.encode(toMap());

  Weekday copyWith({
    String? en,
    String? cn,
    String? ja,
    int? id,
  }) {
    return Weekday(
      en: en ?? this.en,
      cn: cn ?? this.cn,
      ja: ja ?? this.ja,
      id: id ?? this.id,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [en, cn, ja, id];
}
