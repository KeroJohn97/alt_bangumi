import 'dart:convert';

class BrowserRankModel {
  String? id;
  String? cover;
  String? name;
  String? nameCn;
  String? tip;
  String? score;
  String? total;
  String? rank;
  bool? collected;

  BrowserRankModel({
    required this.id,
    required this.cover,
    required this.name,
    required this.nameCn,
    required this.tip,
    required this.score,
    required this.total,
    required this.rank,
    required this.collected,
  });

  @override
  String toString() {
    return 'RankItem(id: $id, cover: $cover, name: $name, nameCn: $nameCn, tip: $tip, score: $score, total: $total, rank: $rank, collected: $collected)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cover': cover,
      'name': name,
      'nameCn': nameCn,
      'tip': tip,
      'score': score,
      'total': total,
      'rank': rank,
      'collected': collected,
    };
  }

  factory BrowserRankModel.fromMap(Map<String, dynamic> map) {
    return BrowserRankModel(
      id: map['id'] != null ? map['id'] as String : null,
      cover: map['cover'] != null ? map['cover'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      nameCn: map['nameCn'] != null ? map['nameCn'] as String : null,
      tip: map['tip'] != null ? map['tip'] as String : null,
      score: map['score'] != null ? map['score'] as String : null,
      total: map['total'] != null ? map['total'] as String : null,
      rank: map['rank'] != null ? map['rank'] as String : null,
      collected: map['collected'] != null ? map['collected'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BrowserRankModel.fromJson(String source) =>
      BrowserRankModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
