import 'dart:convert';

import 'package:equatable/equatable.dart';

class Infobox extends Equatable {
  final String? key;
  final dynamic value; // it's either String or List<Map<String, dynamic>>['v']

  const Infobox({this.key, this.value});

  factory Infobox.fromMap(Map<String, dynamic> data) => Infobox(
        key: data['key'] as String?,
        value: data['value'],
      );

  Map<String, dynamic> toMap() => {
        'key': key,
        'value': value,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Infobox].
  factory Infobox.fromJson(String data) {
    return Infobox.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Infobox] to a JSON string.
  String toJson() => json.encode(toMap());

  Infobox copyWith({
    String? key,
    dynamic value,
  }) {
    return Infobox(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [key, value];
}
