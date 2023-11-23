import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../collection_model.dart';
import '../images_model.dart';
import '../rating_model.dart';

class CalendarItem extends Equatable {
  final int? id;
  final String? url;
  final int? type;
  final String? name;
  final String? nameCn;
  final String? summary;
  final String? airDate;
  final int? airWeekday;
  final ImagesModel? images;
  final int? eps;
  final int? epsCount;
  final RatingModel? rating;
  final int? rank;
  final CollectionModel? collection;

  const CalendarItem({
    this.id,
    this.url,
    this.type,
    this.name,
    this.nameCn,
    this.summary,
    this.airDate,
    this.airWeekday,
    this.images,
    this.eps,
    this.epsCount,
    this.rating,
    this.rank,
    this.collection,
  });

  factory CalendarItem.fromMap(Map<String, dynamic> data) => CalendarItem(
        id: data['id'] as int?,
        url: data['url'] as String?,
        type: data['type'] as int?,
        name: data['name'] as String?,
        nameCn: data['name_cn'] as String?,
        summary: data['summary'] as String?,
        airDate: data['air_date'] as String?,
        airWeekday: data['air_weekday'] as int?,
        images: data['images'] == null
            ? null
            : ImagesModel.fromMap(data['images'] as Map<String, dynamic>),
        eps: data['eps'] as int?,
        epsCount: data['eps_count'] as int?,
        rating: data['rating'] == null
            ? null
            : RatingModel.fromMap(data['rating'] as Map<String, dynamic>),
        rank: data['rank'] as int?,
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
        'air_date': airDate,
        'air_weekday': airWeekday,
        'images': images?.toMap(),
        'eps': eps,
        'eps_count': epsCount,
        'rating': rating?.toMap(),
        'rank': rank,
        'collection': collection?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CalendarItem].
  factory CalendarItem.fromJson(String data) {
    return CalendarItem.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CalendarItem] to a JSON string.
  String toJson() => json.encode(toMap());

  CalendarItem copyWith({
    int? id,
    String? url,
    int? type,
    String? name,
    String? nameCn,
    String? summary,
    String? airDate,
    int? airWeekday,
    ImagesModel? images,
    int? eps,
    int? epsCount,
    RatingModel? rating,
    int? rank,
    CollectionModel? collection,
  }) {
    return CalendarItem(
      id: id ?? this.id,
      url: url ?? this.url,
      type: type ?? this.type,
      name: name ?? this.name,
      nameCn: nameCn ?? this.nameCn,
      summary: summary ?? this.summary,
      airDate: airDate ?? this.airDate,
      airWeekday: airWeekday ?? this.airWeekday,
      images: images ?? this.images,
      eps: eps ?? this.eps,
      epsCount: epsCount ?? this.epsCount,
      rating: rating ?? this.rating,
      rank: rank ?? this.rank,
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
      airDate,
      airWeekday,
      images,
      eps,
      epsCount,
      rating,
      rank,
      collection,
    ];
  }
}
