import 'dart:convert';

import 'package:equatable/equatable.dart';

class CountModel extends Equatable {
  final int? rate1;
  final int? rate2;
  final int? rate3;
  final int? rate4;
  final int? rate5;
  final int? rate6;
  final int? rate7;
  final int? rate8;
  final int? rate9;
  final int? rate10;

  const CountModel({
    this.rate1,
    this.rate2,
    this.rate3,
    this.rate4,
    this.rate5,
    this.rate6,
    this.rate7,
    this.rate8,
    this.rate9,
    this.rate10,
  });

  factory CountModel.fromMap(Map<String, dynamic> data) => CountModel(
        rate1: data['1'] as int?,
        rate2: data['2'] as int?,
        rate3: data['3'] as int?,
        rate4: data['4'] as int?,
        rate5: data['5'] as int?,
        rate6: data['6'] as int?,
        rate7: data['7'] as int?,
        rate8: data['8'] as int?,
        rate9: data['9'] as int?,
        rate10: data['10'] as int?,
      );

  Map<String, dynamic> toMap() => {
        '1': rate1,
        '2': rate2,
        '3': rate3,
        '4': rate4,
        '5': rate5,
        '6': rate6,
        '7': rate7,
        '8': rate8,
        '9': rate9,
        '10': rate10,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CountModel].
  factory CountModel.fromJson(String data) {
    return CountModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CountModel] to a JSON string.
  String toJson() => json.encode(toMap());

  CountModel copyWith({
    int? rate1,
    int? rate2,
    int? rate3,
    int? rate4,
    int? rate5,
    int? rate6,
    int? rate7,
    int? rate8,
    int? rate9,
    int? rate10,
  }) {
    return CountModel(
      rate1: rate1 ?? this.rate1,
      rate2: rate2 ?? this.rate2,
      rate3: rate3 ?? this.rate3,
      rate4: rate4 ?? this.rate4,
      rate5: rate5 ?? this.rate5,
      rate6: rate6 ?? this.rate6,
      rate7: rate7 ?? this.rate7,
      rate8: rate8 ?? this.rate8,
      rate9: rate9 ?? this.rate9,
      rate10: rate10 ?? this.rate10,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        rate1,
        rate2,
        rate3,
        rate4,
        rate5,
        rate6,
        rate7,
        rate8,
        rate9,
        rate10,
      ];
}
