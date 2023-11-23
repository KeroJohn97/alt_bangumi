import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../images_model.dart';

class RelationModel extends Equatable {
  final ImagesModel? images;
  final String? name;
  final String? nameCn;
  final String? relation;
  final List<dynamic>? actors;
  final List<dynamic>? career;
  final int? type;
  final int? id;

  const RelationModel({
    this.images,
    this.name,
    this.nameCn,
    this.relation,
    this.actors,
    this.career,
    this.type,
    this.id,
  });

  factory RelationModel.fromMap(Map<String, dynamic> data) {
    return RelationModel(
      images: data['images'] == null
          ? null
          : ImagesModel.fromMap(data['images'] as Map<String, dynamic>),
      name: data['name'] as String?,
      nameCn: data['name_cn'] as String?,
      relation: data['relation'] as String?,
      actors: data['actors'] as List<dynamic>?,
      career: data['career'] as List<dynamic>?,
      type: data['type'] as int?,
      id: data['id'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        'images': images?.toMap(),
        'name': name,
        'name_cn': nameCn,
        'relation': relation,
        'actors': actors,
        'career': career,
        'type': type,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RelationModel].
  factory RelationModel.fromJson(String data) {
    return RelationModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RelationModel] to a JSON string.
  String toJson() => json.encode(toMap());

  RelationModel copyWith({
    ImagesModel? images,
    String? name,
    String? nameCn,
    String? relation,
    List<dynamic>? actors,
    List<dynamic>? career,
    int? type,
    int? id,
  }) {
    return RelationModel(
      images: images ?? this.images,
      name: name ?? this.name,
      nameCn: nameCn ?? this.nameCn,
      relation: relation ?? this.relation,
      actors: actors ?? this.actors,
      career: career ?? this.career,
      type: type ?? this.type,
      id: id ?? this.id,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props =>
      [images, name, nameCn, relation, actors, career, type, id];
}
