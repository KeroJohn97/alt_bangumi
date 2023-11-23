import 'dart:convert';

import 'package:equatable/equatable.dart';

class InfoboxModel extends Equatable {
  final String? key;
  final dynamic value; // it's either String or List<Map<String, dynamic>>['v']

  const InfoboxModel({this.key, this.value});

  factory InfoboxModel.fromMap(Map<String, dynamic> data) => InfoboxModel(
        key: data['key'] as String?,
        value: data['value'],
      );

  Map<String, dynamic> toMap() => {
        'key': key,
        'value': value,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [InfoboxModel].
  factory InfoboxModel.fromJson(String data) {
    return InfoboxModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [InfoboxModel] to a JSON string.
  String toJson() => json.encode(toMap());

  InfoboxModel copyWith({
    String? key,
    dynamic value,
  }) {
    return InfoboxModel(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [key, value];
}
