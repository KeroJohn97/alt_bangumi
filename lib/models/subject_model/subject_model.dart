import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../collection_model.dart';
import '../images_model.dart';
import 'infobox_model.dart';
import '../rating_model.dart';
import 'tag_model.dart';

class SubjectModel extends Equatable {
  final String? date;
  final String? platform;
  final ImagesModel? images;
  final String? summary;
  final String? name;
  final String? nameCn;
  final List<TagModel>? tags;
  final List<InfoboxModel>? infobox;
  final RatingModel? rating;
  final int? totalEpisodes;
  final CollectionModel? collection;
  final int? id;
  final int? eps;
  final int? volumes;
  final bool? locked;
  final bool? nsfw;
  final int? type;

  const SubjectModel({
    this.date,
    this.platform,
    this.images,
    this.summary,
    this.name,
    this.nameCn,
    this.tags,
    this.infobox,
    this.rating,
    this.totalEpisodes,
    this.collection,
    this.id,
    this.eps,
    this.volumes,
    this.locked,
    this.nsfw,
    this.type,
  });

  factory SubjectModel.fromMap(Map<String, dynamic> data) => SubjectModel(
        date: data['date'] as String?,
        platform: data['platform'] as String?,
        images: data['images'] == null
            ? null
            : ImagesModel.fromMap(data['images'] as Map<String, dynamic>),
        summary: data['summary'] as String?,
        name: data['name'] as String?,
        nameCn: data['name_cn'] as String?,
        tags: (data['tags'] as List<dynamic>?)
            ?.map((e) => TagModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        infobox: (data['infobox'] as List<dynamic>?)
            ?.map((e) => InfoboxModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        rating: data['rating'] == null
            ? null
            : RatingModel.fromMap(data['rating'] as Map<String, dynamic>),
        totalEpisodes: data['total_episodes'] as int?,
        collection: data['collection'] == null
            ? null
            : CollectionModel.fromMap(
                data['collection'] as Map<String, dynamic>),
        id: data['id'] as int?,
        eps: data['eps'] as int?,
        volumes: data['volumes'] as int?,
        locked: data['locked'] as bool?,
        nsfw: data['nsfw'] as bool?,
        type: data['type'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'date': date,
        'platform': platform,
        'images': images?.toMap(),
        'summary': summary,
        'name': name,
        'name_cn': nameCn,
        'tags': tags?.map((e) => e.toMap()).toList(),
        'infobox': infobox?.map((e) => e.toMap()).toList(),
        'rating': rating?.toMap(),
        'total_episodes': totalEpisodes,
        'collection': collection?.toMap(),
        'id': id,
        'eps': eps,
        'volumes': volumes,
        'locked': locked,
        'nsfw': nsfw,
        'type': type,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SubjectModel].
  factory SubjectModel.fromJson(String data) {
    return SubjectModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SubjectModel] to a JSON string.
  String toJson() => json.encode(toMap());

  SubjectModel copyWith({
    String? date,
    String? platform,
    ImagesModel? images,
    String? summary,
    String? name,
    String? nameCn,
    List<TagModel>? tags,
    List<InfoboxModel>? infobox,
    RatingModel? rating,
    int? totalEpisodes,
    CollectionModel? collection,
    int? id,
    int? eps,
    int? volumes,
    bool? locked,
    bool? nsfw,
    int? type,
  }) {
    return SubjectModel(
      date: date ?? this.date,
      platform: platform ?? this.platform,
      images: images ?? this.images,
      summary: summary ?? this.summary,
      name: name ?? this.name,
      nameCn: nameCn ?? this.nameCn,
      tags: tags ?? this.tags,
      infobox: infobox ?? this.infobox,
      rating: rating ?? this.rating,
      totalEpisodes: totalEpisodes ?? this.totalEpisodes,
      collection: collection ?? this.collection,
      id: id ?? this.id,
      eps: eps ?? this.eps,
      volumes: volumes ?? this.volumes,
      locked: locked ?? this.locked,
      nsfw: nsfw ?? this.nsfw,
      type: type ?? this.type,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      date,
      platform,
      images,
      summary,
      name,
      nameCn,
      tags,
      infobox,
      rating,
      totalEpisodes,
      collection,
      id,
      eps,
      volumes,
      locked,
      nsfw,
      type,
    ];
  }
}
