import 'dart:convert';

import 'package:equatable/equatable.dart';

class BlogModel extends Equatable {
  final String? id;
  final String? title;
  final String? cover;
  final String? time;
  final String? replies;
  final String? content;
  final String? username;
  final String? subject;
  final dynamic tags;

  const BlogModel({
    this.id,
    this.title,
    this.cover,
    this.time,
    this.replies,
    this.content,
    this.username,
    this.subject,
    this.tags,
  });

  factory BlogModel.fromMap(Map<String, dynamic> data) => BlogModel(
        id: data['id'] as String?,
        title: data['title'] as String?,
        cover: data['cover'] as String?,
        time: data['time'] as String?,
        replies: data['replies'] as String?,
        content: data['content'] as String?,
        username: data['username'] as String?,
        subject: data['subject'] as String?,
        tags: data['tags'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'cover': cover,
        'time': time,
        'replies': replies,
        'content': content,
        'username': username,
        'subject': subject,
        'tags': tags,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BlogModel].
  factory BlogModel.fromJson(String data) {
    return BlogModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BlogModel] to a JSON string.
  String toJson() => json.encode(toMap());

  BlogModel copyWith({
    String? id,
    String? title,
    String? cover,
    String? time,
    String? replies,
    String? content,
    String? username,
    String? subject,
    dynamic tags,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      cover: cover ?? this.cover,
      time: time ?? this.time,
      replies: replies ?? this.replies,
      content: content ?? this.content,
      username: username ?? this.username,
      subject: subject ?? this.subject,
      tags: tags ?? this.tags,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      cover,
      time,
      replies,
      content,
      username,
      subject,
      tags,
    ];
  }
}
