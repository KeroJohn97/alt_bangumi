import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'anime.dart';
import 'book.dart';
import 'game.dart';
import 'music.dart';
import 'film.dart';

class HomeDiscoveryModel extends Equatable {
  final List<Anime>? anime;
  final List<Game>? game;
  final List<Book>? book;
  final List<Music>? music;
  final List<Film>? film;
  final String? today;

  const HomeDiscoveryModel({
    this.anime,
    this.game,
    this.book,
    this.music,
    this.film,
    this.today,
  });

  factory HomeDiscoveryModel.fromMap(Map<String, dynamic> data) {
    return HomeDiscoveryModel(
      anime: (data['anime'] as List<dynamic>?)
          ?.map((e) => Anime.fromMap(e as Map<String, dynamic>))
          .toList(),
      game: (data['game'] as List<dynamic>?)
          ?.map((e) => Game.fromMap(e as Map<String, dynamic>))
          .toList(),
      book: (data['book'] as List<dynamic>?)
          ?.map((e) => Book.fromMap(e as Map<String, dynamic>))
          .toList(),
      music: (data['music'] as List<dynamic>?)
          ?.map((e) => Music.fromMap(e as Map<String, dynamic>))
          .toList(),
      film: (data['real'] as List<dynamic>?)
          ?.map((e) => Film.fromMap(e as Map<String, dynamic>))
          .toList(),
      today: data['today'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'anime': anime?.map((e) => e.toMap()).toList(),
        'game': game?.map((e) => e.toMap()).toList(),
        'book': book?.map((e) => e.toMap()).toList(),
        'music': music?.map((e) => e.toMap()).toList(),
        'real': film?.map((e) => e.toMap()).toList(),
        'today': today,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [HomeDiscoveryModel].
  factory HomeDiscoveryModel.fromJson(String data) {
    return HomeDiscoveryModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [HomeDiscoveryModel] to a JSON string.
  String toJson() => json.encode(toMap());

  HomeDiscoveryModel copyWith({
    List<Anime>? anime,
    List<Game>? game,
    List<Book>? book,
    List<Music>? music,
    List<Film>? film,
    String? today,
  }) {
    return HomeDiscoveryModel(
      anime: anime ?? this.anime,
      game: game ?? this.game,
      book: book ?? this.book,
      music: music ?? this.music,
      film: film ?? this.film,
      today: today ?? this.today,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [anime, game, book, music, film, today];
}
