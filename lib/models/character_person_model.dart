import 'dart:convert';

import 'package:alt_bangumi/models/images_model.dart';
import 'package:equatable/equatable.dart';

class CharacterPersonModel extends Equatable {
  final ImagesModel? images;
  final String? name;
  final String? subjectName;
  final String? subjectNameCn;
  final int? subjectId;
  final String? staff;
  final int? id;
  final int? type;

  const CharacterPersonModel({
    this.images,
    this.name,
    this.subjectName,
    this.subjectNameCn,
    this.subjectId,
    this.staff,
    this.id,
    this.type,
  });

  factory CharacterPersonModel.fromMap(Map<String, dynamic> data) {
    return CharacterPersonModel(
      images: data['images'] == null
          ? null
          : ImagesModel.fromMap(data['images'] as Map<String, dynamic>),
      name: data['name'] as String?,
      subjectName: data['subject_name'] as String?,
      subjectNameCn: data['subject_name_cn'] as String?,
      subjectId: data['subject_id'] as int?,
      staff: data['staff'] as String?,
      id: data['id'] as int?,
      type: data['type'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        'images': images?.toMap(),
        'name': name,
        'subject_name': subjectName,
        'subject_name_cn': subjectNameCn,
        'subject_id': subjectId,
        'staff': staff,
        'id': id,
        'type': type,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CharacterPersonModel].
  factory CharacterPersonModel.fromJson(String data) {
    return CharacterPersonModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CharacterPersonModel] to a JSON string.
  String toJson() => json.encode(toMap());

  CharacterPersonModel copyWith({
    ImagesModel? images,
    String? name,
    String? subjectName,
    String? subjectNameCn,
    int? subjectId,
    String? staff,
    int? id,
    int? type,
  }) {
    return CharacterPersonModel(
      images: images ?? this.images,
      name: name ?? this.name,
      subjectName: subjectName ?? this.subjectName,
      subjectNameCn: subjectNameCn ?? this.subjectNameCn,
      subjectId: subjectId ?? this.subjectId,
      staff: staff ?? this.staff,
      id: id ?? this.id,
      type: type ?? this.type,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      images,
      name,
      subjectName,
      subjectNameCn,
      subjectId,
      staff,
      id,
      type,
    ];
  }
}
