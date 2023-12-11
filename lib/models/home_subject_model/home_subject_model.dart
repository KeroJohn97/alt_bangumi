import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'ep_model.dart';
import 'site_model.dart';

class HomeSubjectModel extends Equatable {
  final String? id;
  final String? name;
  final List<SiteModel>? sites;
  final List<EpModel>? eps;

  const HomeSubjectModel({this.id, this.name, this.sites, this.eps});

  factory HomeSubjectModel.fromMap(Map<String, dynamic> data) =>
      HomeSubjectModel(
        id: data['id'] as String?,
        name: data['name'] as String?,
        sites: (data['sites'] as List<dynamic>?)
            ?.map((e) => SiteModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        eps: (data['eps'] as List<dynamic>?)
            ?.map((e) => EpModel.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'sites': sites?.map((e) => e.toMap()).toList(),
        'eps': eps?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [HomeSubjectModel].
  factory HomeSubjectModel.fromJson(String data) {
    return HomeSubjectModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [HomeSubjectModel] to a JSON string.
  String toJson() => json.encode(toMap());

  HomeSubjectModel copyWith({
    String? id,
    String? name,
    List<SiteModel>? sites,
    List<EpModel>? eps,
  }) {
    return HomeSubjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      sites: sites ?? this.sites,
      eps: eps ?? this.eps,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, sites, eps];
}
