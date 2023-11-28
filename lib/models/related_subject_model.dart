import 'dart:convert';

import 'package:equatable/equatable.dart';

class RelatedSubjectModel extends Equatable {
  final String? staff;
  final String? name;
  final String? nameCn;
  final String? image;
  final int? id;

  const RelatedSubjectModel({
    this.staff,
    this.name,
    this.nameCn,
    this.image,
    this.id,
  });

  factory RelatedSubjectModel.fromMap(Map<String, dynamic> data) {
    return RelatedSubjectModel(
      staff: data['staff'] as String?,
      name: data['name'] as String?,
      nameCn: data['name_cn'] as String?,
      image: data['image'] as String?,
      id: data['id'] as int?,
    );
  }

  Map<String, dynamic> toMap() => {
        'staff': staff,
        'name': name,
        'name_cn': nameCn,
        'image': image,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RelatedSubjectModel].
  factory RelatedSubjectModel.fromJson(String data) {
    return RelatedSubjectModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RelatedSubjectModel] to a JSON string.
  String toJson() => json.encode(toMap());

  RelatedSubjectModel copyWith({
    String? staff,
    String? name,
    String? nameCn,
    String? image,
    int? id,
  }) {
    return RelatedSubjectModel(
      staff: staff ?? this.staff,
      name: name ?? this.name,
      nameCn: nameCn ?? this.nameCn,
      image: image ?? this.image,
      id: id ?? this.id,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [staff, name, nameCn, image, id];
}
