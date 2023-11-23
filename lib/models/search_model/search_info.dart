import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../collection_model.dart';
import '../images_model.dart';
import '../rating_model.dart';

class SearchInfo extends Equatable {
  final int? id;
  final String? url;
  final int? type;
  final String? name;
  final String? nameCn;
  final String? summary;
  final int? eps;
  final int? epsCount;
  final String? airDate;
  final int? airWeekday;
  final RatingModel? rating;
  final int? rank;
  final ImagesModel? images;
  final CollectionModel? collection;

  const SearchInfo({
    this.id,
    this.url,
    this.type,
    this.name,
    this.nameCn,
    this.summary,
    this.eps,
    this.epsCount,
    this.airDate,
    this.airWeekday,
    this.rating,
    this.rank,
    this.images,
    this.collection,
  });

  factory SearchInfo.fromMap(Map<String, dynamic> data) => SearchInfo(
        id: data['id'] as int?,
        url: data['url'] as String?,
        type: data['type'] as int?,
        name: data['name'] as String?,
        nameCn: data['name_cn'] as String?,
        summary: data['summary'] as String?,
        eps: data['eps'] as int?,
        epsCount: data['eps_count'] as int?,
        airDate: data['air_date'] as String?,
        airWeekday: data['air_weekday'] as int?,
        rating: data['rating'] == null
            ? null
            : RatingModel.fromMap(data['rating'] as Map<String, dynamic>),
        rank: data['rank'] as int?,
        images: data['images'] == null
            ? null
            : ImagesModel.fromMap(data['images'] as Map<String, dynamic>),
        collection: data['collection'] == null
            ? null
            : CollectionModel.fromMap(
                data['collection'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'url': url,
        'type': type,
        'name': name,
        'name_cn': nameCn,
        'summary': summary,
        'eps': eps,
        'eps_count': epsCount,
        'air_date': airDate,
        'air_weekday': airWeekday,
        'rating': rating?.toMap(),
        'rank': rank,
        'images': images?.toMap(),
        'collection': collection?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [List].
  factory SearchInfo.fromJson(String data) {
    return SearchInfo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [List] to a JSON string.
  String toJson() => json.encode(toMap());

  SearchInfo copyWith({
    int? id,
    String? url,
    int? type,
    String? name,
    String? nameCn,
    String? summary,
    int? eps,
    int? epsCount,
    String? airDate,
    int? airWeekday,
    RatingModel? rating,
    int? rank,
    ImagesModel? images,
    CollectionModel? collection,
  }) {
    return SearchInfo(
      id: id ?? this.id,
      url: url ?? this.url,
      type: type ?? this.type,
      name: name ?? this.name,
      nameCn: nameCn ?? this.nameCn,
      summary: summary ?? this.summary,
      eps: eps ?? this.eps,
      epsCount: epsCount ?? this.epsCount,
      airDate: airDate ?? this.airDate,
      airWeekday: airWeekday ?? this.airWeekday,
      rating: rating ?? this.rating,
      rank: rank ?? this.rank,
      images: images ?? this.images,
      collection: collection ?? this.collection,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      url,
      type,
      name,
      nameCn,
      summary,
      eps,
      epsCount,
      airDate,
      airWeekday,
      rating,
      rank,
      images,
      collection,
    ];
  }
}
