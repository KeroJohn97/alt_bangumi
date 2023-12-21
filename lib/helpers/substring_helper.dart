import 'dart:convert';

import 'package:alt_bangumi/gen/assets.gen.dart';
import 'package:flutter/services.dart';

class SubstringHelper {
  static final SubstringHelper _instance = SubstringHelper._();

  SubstringHelper._();

  factory SubstringHelper.instance() => _instance;

  final Map<String, dynamic> _alias = {};

  final Map<String, dynamic> _anime = {};

  final Map<String, dynamic> _book = {};

  final Map<String, dynamic> _game = {};

  Future<void> _loadJson() async {
    if (_alias.isNotEmpty ||
        _anime.isNotEmpty ||
        _book.isNotEmpty ||
        _game.isNotEmpty) {
      _alias.clear();
      _anime.clear();
      _book.clear();
      _game.clear();
    }
    final alias = await rootBundle.loadString(Assets.json.substrings.alias);
    _alias.addAll(jsonDecode(alias));
    final anime = await rootBundle.loadString(Assets.json.substrings.anime);
    _anime.addAll(jsonDecode(anime));
    final book = await rootBundle.loadString(Assets.json.substrings.book);
    _book.addAll(jsonDecode(book));
    final game = await rootBundle.loadString(Assets.json.substrings.game);
    _game.addAll(jsonDecode(game));
  }

  Future<Map<String, dynamic>> _getAlias() async {
    if (_alias.isEmpty) await _loadJson();
    return _alias;
  }

  Future<Map<String, dynamic>> _getAnime() async {
    if (_anime.isEmpty) await _loadJson();
    return _anime;
  }

  Future<Map<String, dynamic>> _getBook() async {
    if (_book.isEmpty) await _loadJson();
    return _book;
  }

  Future<Map<String, dynamic>> _getGame() async {
    if (_game.isEmpty) await _loadJson();
    return _game;
  }

  Future<Map<String, dynamic>> getAliasList() async {
    return await _getAlias();
  }

  Future<Map<String, dynamic>> getAnimeList() async {
    return await _getAnime();
  }

  Future<Map<String, dynamic>> getBookList() async {
    return await _getBook();
  }

  Future<Map<String, dynamic>> getGameList() async {
    return await _getGame();
  }
}
