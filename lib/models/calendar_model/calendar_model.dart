import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'calendar_item.dart';
import 'weekday.dart';

class CalendarModel extends Equatable {
  final Weekday? weekday;
  final List<CalendarItem>? items;

  const CalendarModel({this.weekday, this.items});

  factory CalendarModel.fromMap(Map<String, dynamic> data) => CalendarModel(
        weekday: data['weekday'] == null
            ? null
            : Weekday.fromMap(data['weekday'] as Map<String, dynamic>),
        items: (data['items'] as List<dynamic>?)
            ?.map((e) => CalendarItem.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'weekday': weekday?.toMap(),
        'items': items?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CalendarModel].
  factory CalendarModel.fromJson(String data) {
    return CalendarModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CalendarModel] to a JSON string.
  String toJson() => json.encode(toMap());

  CalendarModel copyWith({
    Weekday? weekday,
    List<CalendarItem>? items,
  }) {
    return CalendarModel(
      weekday: weekday ?? this.weekday,
      items: items ?? this.items,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [weekday, items];
}
