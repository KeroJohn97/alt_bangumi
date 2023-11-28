import 'dart:convert';

import 'package:equatable/equatable.dart';

class DiscussModel extends Equatable {
  final String? id;
  final String? title;
  final String? replies;
  final String? subjectId;
  final String? subjectName;
  final String? userId;
  final String? userName;
  final String? time;

  const DiscussModel({
    this.id,
    this.title,
    this.replies,
    this.subjectId,
    this.subjectName,
    this.userId,
    this.userName,
    this.time,
  });

  factory DiscussModel.fromMap(Map<String, dynamic> data) => DiscussModel(
        id: data['id'] as String?,
        title: data['title'] as String?,
        replies: data['replies'] as String?,
        subjectId: data['subjectId'] as String?,
        subjectName: data['subjectName'] as String?,
        userId: data['userId'] as String?,
        userName: data['userName'] as String?,
        time: data['time'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'replies': replies,
        'subjectId': subjectId,
        'subjectName': subjectName,
        'userId': userId,
        'userName': userName,
        'time': time,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DiscussModel].
  factory DiscussModel.fromJson(String data) {
    return DiscussModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DiscussModel] to a JSON string.
  String toJson() => json.encode(toMap());

  DiscussModel copyWith({
    String? id,
    String? title,
    String? replies,
    String? subjectId,
    String? subjectName,
    String? userId,
    String? userName,
    String? time,
  }) {
    return DiscussModel(
      id: id ?? this.id,
      title: title ?? this.title,
      replies: replies ?? this.replies,
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      time: time ?? this.time,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      replies,
      subjectId,
      subjectName,
      userId,
      userName,
      time,
    ];
  }
}
