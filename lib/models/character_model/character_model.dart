import 'dart:convert';

import 'package:alt_bangumi/models/images_model.dart';
import 'package:alt_bangumi/models/subject_model/infobox_model.dart';
import 'package:equatable/equatable.dart';

import '../stat_model.dart';

class CharacterModel extends Equatable {
  final dynamic birthMon;
  final String? gender;
  final dynamic birthDay;
  final dynamic birthYear;
  final dynamic bloodType;
  final ImagesModel? images;
  final String? summary;
  final String? name;
  final List<InfoboxModel>? infobox;
  final StatModel? stat;
  final int? id;
  final bool? locked;
  final int? type;
  final bool? nsfw;

  const CharacterModel({
    this.birthMon,
    this.gender,
    this.birthDay,
    this.birthYear,
    this.bloodType,
    this.images,
    this.summary,
    this.name,
    this.infobox,
    this.stat,
    this.id,
    this.locked,
    this.type,
    this.nsfw,
  });

  factory CharacterModel.fromMap(Map<String, dynamic> data) {
    return CharacterModel(
      birthMon: data['birth_mon'] as dynamic,
      gender: data['gender'] as String?,
      birthDay: data['birth_day'] as dynamic,
      birthYear: data['birth_year'] as dynamic,
      bloodType: data['blood_type'] as dynamic,
      images: data['images'] == null
          ? null
          : ImagesModel.fromMap(data['images'] as Map<String, dynamic>),
      summary: data['summary'] as String?,
      name: data['name'] as String?,
      infobox: (data['infobox'] as List<dynamic>?)
          ?.map((e) => InfoboxModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      stat: data['stat'] == null
          ? null
          : StatModel.fromMap(data['stat'] as Map<String, dynamic>),
      id: data['id'] as int?,
      locked: data['locked'] as bool?,
      type: data['type'] as int?,
      nsfw: data['nsfw'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'birth_mon': birthMon,
        'gender': gender,
        'birth_day': birthDay,
        'birth_year': birthYear,
        'blood_type': bloodType,
        'images': images?.toMap(),
        'summary': summary,
        'name': name,
        'infobox': infobox?.map((e) => e.toMap()).toList(),
        'stat': stat?.toMap(),
        'id': id,
        'locked': locked,
        'type': type,
        'nsfw': nsfw,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CharacterModel].
  factory CharacterModel.fromJson(String data) {
    return CharacterModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CharacterModel] to a JSON string.
  String toJson() => json.encode(toMap());

  CharacterModel copyWith({
    dynamic birthMon,
    String? gender,
    dynamic birthDay,
    dynamic birthYear,
    dynamic bloodType,
    ImagesModel? images,
    String? summary,
    String? name,
    List<InfoboxModel>? infobox,
    StatModel? stat,
    int? id,
    bool? locked,
    int? type,
    bool? nsfw,
  }) {
    return CharacterModel(
      birthMon: birthMon ?? this.birthMon,
      gender: gender ?? this.gender,
      birthDay: birthDay ?? this.birthDay,
      birthYear: birthYear ?? this.birthYear,
      bloodType: bloodType ?? this.bloodType,
      images: images ?? this.images,
      summary: summary ?? this.summary,
      name: name ?? this.name,
      infobox: infobox ?? this.infobox,
      stat: stat ?? this.stat,
      id: id ?? this.id,
      locked: locked ?? this.locked,
      type: type ?? this.type,
      nsfw: nsfw ?? this.nsfw,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      birthMon,
      gender,
      birthDay,
      birthYear,
      bloodType,
      images,
      summary,
      name,
      infobox,
      stat,
      id,
      locked,
      type,
      nsfw,
    ];
  }
}
