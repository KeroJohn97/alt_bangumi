import 'dart:convert';

import 'package:equatable/equatable.dart';

class DatumModel extends Equatable {
  final String? airdate;
  final String? name;
  final String? nameCn;
  final String? duration;
  final String? desc;
  final int? ep;
  final num? sort;
  final int? id;
  final int? subjectId;
  final int? comment;
  final int? type;
  final int? disc;
  final int? durationSeconds;

  const DatumModel({
    this.airdate,
    this.name,
    this.nameCn,
    this.duration,
    this.desc,
    this.ep,
    this.sort,
    this.id,
    this.subjectId,
    this.comment,
    this.type,
    this.disc,
    this.durationSeconds,
  });

  factory DatumModel.fromMap(Map<String, dynamic> data) => DatumModel(
        airdate: data['airdate'] as String?,
        name: data['name'] as String?,
        nameCn: data['name_cn'] as String?,
        duration: data['duration'] as String?,
        desc: data['desc'] as String?,
        ep: data['ep'] as int?,
        sort: data['sort'] as num?,
        id: data['id'] as int?,
        subjectId: data['subject_id'] as int?,
        comment: data['comment'] as int?,
        type: data['type'] as int?,
        disc: data['disc'] as int?,
        durationSeconds: data['duration_seconds'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'airdate': airdate,
        'name': name,
        'name_cn': nameCn,
        'duration': duration,
        'desc': desc,
        'ep': ep,
        'sort': sort,
        'id': id,
        'subject_id': subjectId,
        'comment': comment,
        'type': type,
        'disc': disc,
        'duration_seconds': durationSeconds,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DatumModel].
  factory DatumModel.fromJson(String data) {
    return DatumModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DatumModel] to a JSON string.
  String toJson() => json.encode(toMap());

  DatumModel copyWith({
    String? airdate,
    String? name,
    String? nameCn,
    String? duration,
    String? desc,
    int? ep,
    double? sort,
    int? id,
    int? subjectId,
    int? comment,
    int? type,
    int? disc,
    int? durationSeconds,
  }) {
    return DatumModel(
      airdate: airdate ?? this.airdate,
      name: name ?? this.name,
      nameCn: nameCn ?? this.nameCn,
      duration: duration ?? this.duration,
      desc: desc ?? this.desc,
      ep: ep ?? this.ep,
      sort: sort ?? this.sort,
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      comment: comment ?? this.comment,
      type: type ?? this.type,
      disc: disc ?? this.disc,
      durationSeconds: durationSeconds ?? this.durationSeconds,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      airdate,
      name,
      nameCn,
      duration,
      desc,
      ep,
      sort,
      id,
      subjectId,
      comment,
      type,
      disc,
      durationSeconds,
    ];
  }
}
