import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'ep.dart';

class CalendarItemModel extends Equatable {
  final int? id;
  final String? name;
  final String? nameCn;
  final String? airDate;
  final int? weekDayJp;
  final int? weekDayCn;
  final String? timeJp;
  final String? timeCn;
  final String? image;
  final List<dynamic>? sites;
  final List<Ep>? eps;

  const CalendarItemModel({
    this.id,
    this.name,
    this.nameCn,
    this.airDate,
    this.weekDayJp,
    this.weekDayCn,
    this.timeJp,
    this.timeCn,
    this.image,
    this.sites,
    this.eps,
  });

  factory CalendarItemModel.fromMap(Map<String, dynamic> data) {
    return CalendarItemModel(
      id: data['id'] as int?,
      name: data['name'] as String?,
      nameCn: data['name_cn'] as String?,
      airDate: data['air_date'] as String?,
      weekDayJp: data['weekDayJP'] as int?,
      weekDayCn: data['weekDayCN'] as int?,
      timeJp: data['timeJP'] as String?,
      timeCn: data['timeCN'] as String?,
      image: data['image'] as String?,
      sites: data['sites'] as List<dynamic>?,
      eps: (data['eps'] as List<dynamic>?)
          ?.map((e) => Ep.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'name_cn': nameCn,
        'air_date': airDate,
        'weekDayJP': weekDayJp,
        'weekDayCN': weekDayCn,
        'timeJP': timeJp,
        'timeCN': timeCn,
        'image': image,
        'sites': sites,
        'eps': eps?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CalendarItemModel].
  factory CalendarItemModel.fromJson(String data) {
    return CalendarItemModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CalendarItemModel] to a JSON string.
  String toJson() => json.encode(toMap());

  CalendarItemModel copyWith({
    int? id,
    String? name,
    String? nameCn,
    String? airDate,
    int? weekDayJp,
    int? weekDayCn,
    String? timeJp,
    String? timeCn,
    String? image,
    List<dynamic>? sites,
    List<Ep>? eps,
  }) {
    return CalendarItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nameCn: nameCn ?? this.nameCn,
      airDate: airDate ?? this.airDate,
      weekDayJp: weekDayJp ?? this.weekDayJp,
      weekDayCn: weekDayCn ?? this.weekDayCn,
      timeJp: timeJp ?? this.timeJp,
      timeCn: timeCn ?? this.timeCn,
      image: image ?? this.image,
      sites: sites ?? this.sites,
      eps: eps ?? this.eps,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      nameCn,
      airDate,
      weekDayJp,
      weekDayCn,
      timeJp,
      timeCn,
      image,
      sites,
      eps,
    ];
  }
}
