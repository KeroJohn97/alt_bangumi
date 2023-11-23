import 'dart:convert';

import 'package:equatable/equatable.dart';

class ImagesModel extends Equatable {
  final String? small;
  final String? grid;
  final String? large;
  final String? medium;
  final String? common;

  const ImagesModel({
    this.small,
    this.grid,
    this.large,
    this.medium,
    this.common,
  });

  factory ImagesModel.fromMap(Map<String, dynamic> data) => ImagesModel(
        small: data['small'] as String?,
        grid: data['grid'] as String?,
        large: data['large'] as String?,
        medium: data['medium'] as String?,
        common: data['common'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'small': small,
        'grid': grid,
        'large': large,
        'medium': medium,
        'common': common,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ImagesModel].
  factory ImagesModel.fromJson(String data) {
    return ImagesModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ImagesModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ImagesModel copyWith({
    String? small,
    String? grid,
    String? large,
    String? medium,
    String? common,
  }) {
    return ImagesModel(
      small: small ?? this.small,
      grid: grid ?? this.grid,
      large: large ?? this.large,
      medium: medium ?? this.medium,
      common: common ?? this.common,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [small, grid, large, medium, common];
}
