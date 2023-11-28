import 'dart:convert';

import 'package:alt_bangumi/models/images_model.dart';
import 'package:equatable/equatable.dart';

class ActorModel extends Equatable {
  final ImagesModel? images;
  final String? name;
  final String? shortSummary;
  final List<String>? career;
  final int? id;
  final int? type;
  final bool? locked;

  const ActorModel({
    this.images,
    this.name,
    this.shortSummary,
    this.career,
    this.id,
    this.type,
    this.locked,
  });

  factory ActorModel.fromMap(Map<String, dynamic> data) => ActorModel(
        images: data['images'] == null
            ? null
            : ImagesModel.fromMap(data['images'] as Map<String, dynamic>),
        name: data['name'] as String?,
        shortSummary: data['short_summary'] as String?,
        career: (data['career'] as List<dynamic>?)?.map((e) => '$e').toList(),
        id: data['id'] as int?,
        type: data['type'] as int?,
        locked: data['locked'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'images': images?.toMap(),
        'name': name,
        'short_summary': shortSummary,
        'career': career,
        'id': id,
        'type': type,
        'locked': locked,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ActorModel].
  factory ActorModel.fromJson(String data) {
    return ActorModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ActorModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ActorModel copyWith({
    ImagesModel? images,
    String? name,
    String? shortSummary,
    List<String>? career,
    int? id,
    int? type,
    bool? locked,
  }) {
    return ActorModel(
      images: images ?? this.images,
      name: name ?? this.name,
      shortSummary: shortSummary ?? this.shortSummary,
      career: career ?? this.career,
      id: id ?? this.id,
      type: type ?? this.type,
      locked: locked ?? this.locked,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      images,
      name,
      shortSummary,
      career,
      id,
      type,
      locked,
    ];
  }
}
