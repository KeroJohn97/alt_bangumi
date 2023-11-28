import 'dart:convert';

import 'package:alt_bangumi/models/images_model.dart';
import 'package:alt_bangumi/models/stat_model.dart';
import 'package:alt_bangumi/models/subject_model/infobox_model.dart';
import 'package:equatable/equatable.dart';

class PersonModel extends Equatable {
  final String? lastModified;
  final int? bloodType;
  final int? birthYear;
  final int? birthDay;
  final int? birthMon;
  final String? gender;
  final ImagesModel? images;
  final String? summary;
  final String? name;
  final String? img;
  final List<InfoboxModel>? infobox;
  final List<String>? career;
  final StatModel? stat;
  final int? id;
  final bool? locked;
  final int? type;

  const PersonModel({
    this.lastModified,
    this.bloodType,
    this.birthYear,
    this.birthDay,
    this.birthMon,
    this.gender,
    this.images,
    this.summary,
    this.name,
    this.img,
    this.infobox,
    this.career,
    this.stat,
    this.id,
    this.locked,
    this.type,
  });

  factory PersonModel.fromMap(Map<String, dynamic> data) => PersonModel(
        lastModified: data['last_modified'] as String?,
        bloodType: data['blood_type'] as int?,
        birthYear: data['birth_year'] as int?,
        birthDay: data['birth_day'] as int?,
        birthMon: data['birth_mon'] as int?,
        gender: data['gender'] as String?,
        images: data['images'] == null
            ? null
            : ImagesModel.fromMap(data['images'] as Map<String, dynamic>),
        summary: data['summary'] as String?,
        name: data['name'] as String?,
        img: data['img'] as String?,
        infobox: (data['infobox'] as List<dynamic>?)
            ?.map((e) => InfoboxModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        career: (data['career'] as List<dynamic>?)?.map((e) => '$e').toList(),
        stat: data['stat'] == null
            ? null
            : StatModel.fromMap(data['stat'] as Map<String, dynamic>),
        id: data['id'] as int?,
        locked: data['locked'] as bool?,
        type: data['type'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'last_modified': lastModified,
        'blood_type': bloodType,
        'birth_year': birthYear,
        'birth_day': birthDay,
        'birth_mon': birthMon,
        'gender': gender,
        'images': images?.toMap(),
        'summary': summary,
        'name': name,
        'img': img,
        'infobox': infobox?.map((e) => e.toMap()).toList(),
        'career': career,
        'stat': stat?.toMap(),
        'id': id,
        'locked': locked,
        'type': type,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PersonModel].
  factory PersonModel.fromJson(String data) {
    return PersonModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PersonModel] to a JSON string.
  String toJson() => json.encode(toMap());

  PersonModel copyWith({
    String? lastModified,
    int? bloodType,
    int? birthYear,
    int? birthDay,
    int? birthMon,
    String? gender,
    ImagesModel? images,
    String? summary,
    String? name,
    String? img,
    List<InfoboxModel>? infobox,
    List<String>? career,
    StatModel? stat,
    int? id,
    bool? locked,
    int? type,
  }) {
    return PersonModel(
      lastModified: lastModified ?? this.lastModified,
      bloodType: bloodType ?? this.bloodType,
      birthYear: birthYear ?? this.birthYear,
      birthDay: birthDay ?? this.birthDay,
      birthMon: birthMon ?? this.birthMon,
      gender: gender ?? this.gender,
      images: images ?? this.images,
      summary: summary ?? this.summary,
      name: name ?? this.name,
      img: img ?? this.img,
      infobox: infobox ?? this.infobox,
      career: career ?? this.career,
      stat: stat ?? this.stat,
      id: id ?? this.id,
      locked: locked ?? this.locked,
      type: type ?? this.type,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      lastModified,
      bloodType,
      birthYear,
      birthDay,
      birthMon,
      gender,
      images,
      summary,
      name,
      img,
      infobox,
      career,
      stat,
      id,
      locked,
      type,
    ];
  }
}
