import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'blog_model.dart';
import 'discuss_model.dart';
import 'rank_model.dart';
import 'rank_top_model.dart';

class ChannelModel extends Equatable {
  final List<RankTopModel>? rankTop;
  final List<RankModel>? rank;
  final dynamic friends;
  final List<String>? tags;
  final List<DiscussModel>? discuss;
  final List<BlogModel>? blog;

  const ChannelModel({
    this.rankTop,
    this.rank,
    this.friends,
    this.tags,
    this.discuss,
    this.blog,
  });

  factory ChannelModel.fromMap(Map<String, dynamic> data) => ChannelModel(
        rankTop: (data['rankTop'] as List<dynamic>?)
            ?.map((e) => RankTopModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        rank: (data['rank'] as List<dynamic>?)
            ?.map((e) => RankModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        friends: data['friends'] as dynamic,
        tags: data['tags'] as List<String>?,
        discuss: (data['discuss'] as List<dynamic>?)
            ?.map((e) => DiscussModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        blog: (data['blog'] as List<dynamic>?)
            ?.map((e) => BlogModel.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'rankTop': rankTop?.map((e) => e.toMap()).toList(),
        'rank': rank?.map((e) => e.toMap()).toList(),
        'friends': friends,
        'tags': tags,
        'discuss': discuss?.map((e) => e.toMap()).toList(),
        'blog': blog?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChannelModel].
  factory ChannelModel.fromJson(String data) {
    return ChannelModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ChannelModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ChannelModel copyWith({
    List<RankTopModel>? rankTop,
    List<RankModel>? rank,
    dynamic friends,
    List<String>? tags,
    List<DiscussModel>? discuss,
    List<BlogModel>? blog,
  }) {
    return ChannelModel(
      rankTop: rankTop ?? this.rankTop,
      rank: rank ?? this.rank,
      friends: friends ?? this.friends,
      tags: tags ?? this.tags,
      discuss: discuss ?? this.discuss,
      blog: blog ?? this.blog,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      rankTop,
      rank,
      friends,
      tags,
      discuss,
      blog,
    ];
  }
}
