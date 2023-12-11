// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/helpers/storage_helper.dart';
import 'package:alt_bangumi/models/subject_model/subject_model.dart';
import 'package:alt_bangumi/repositories/bad_repository.dart';
import 'package:alt_bangumi/repositories/global_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alt_bangumi/models/channel_model/channel_model.dart';

enum DiscoverViewStateEnum { initial, loading, failure, success }

class DiscoverViewState {
  final DiscoverViewStateEnum stateEnum;
  final Map<ScreenSubjectOption, ChannelModel>? channel;
  final List<SubjectModel>? rankedAnime;
  final List<SubjectModel>? rankedBook;
  final List<SubjectModel>? rankedMusic;
  final List<SubjectModel>? rankedGame;
  final List<SubjectModel>? rankedReal;

  DiscoverViewState({
    required this.stateEnum,
    required this.channel,
    required this.rankedAnime,
    required this.rankedBook,
    required this.rankedMusic,
    required this.rankedGame,
    required this.rankedReal,
  });

  DiscoverViewState copyWith({
    DiscoverViewStateEnum? stateEnum,
    Map<ScreenSubjectOption, ChannelModel>? channel,
    List<SubjectModel>? rankedAnime,
    List<SubjectModel>? rankedBook,
    List<SubjectModel>? rankedMusic,
    List<SubjectModel>? rankedGame,
    List<SubjectModel>? rankedReal,
  }) {
    return DiscoverViewState(
      stateEnum: stateEnum ?? this.stateEnum,
      channel: channel ?? this.channel,
      rankedAnime: rankedAnime ?? this.rankedAnime,
      rankedBook: rankedBook ?? this.rankedBook,
      rankedGame: rankedGame ?? this.rankedGame,
      rankedMusic: rankedMusic ?? this.rankedMusic,
      rankedReal: rankedReal ?? this.rankedReal,
    );
  }
}

class DiscoverViewStateNotifier extends StateNotifier<DiscoverViewState> {
  DiscoverViewStateNotifier()
      : super(
          DiscoverViewState(
            stateEnum: DiscoverViewStateEnum.initial,
            channel: null,
            rankedAnime: null,
            rankedBook: null,
            rankedGame: null,
            rankedMusic: null,
            rankedReal: null,
          ),
        );

  void initChannel() async {
    final storage = await StorageHelper.read(StorageHelperOption.homeAnimeList);
    if (storage == null) return loadChannel();
    final data = jsonDecode(storage);
    final List<dynamic> tempAnime = data[ScreenSubjectOption.anime.toJson()];
    final rankedAnime = tempAnime.map((e) => SubjectModel.fromJson(e)).toList();
    final List<dynamic> tempBook = data[ScreenSubjectOption.book.toJson()];
    final rankedBook = tempBook.map((e) => SubjectModel.fromJson(e)).toList();
    final List<dynamic> tempGame = data[ScreenSubjectOption.game.toJson()];
    final rankedGame = tempGame.map((e) => SubjectModel.fromJson(e)).toList();
    final List<dynamic> tempMusic = data[ScreenSubjectOption.music.toJson()];
    final rankedMusic = tempMusic.map((e) => SubjectModel.fromJson(e)).toList();
    final List<dynamic> tempReal = data[ScreenSubjectOption.real.toJson()];
    final rankedReal = tempReal.map((e) => SubjectModel.fromJson(e)).toList();
    state = state.copyWith(
      stateEnum: DiscoverViewStateEnum.success,
      rankedAnime: rankedAnime,
      rankedBook: rankedBook,
      rankedGame: rankedGame,
      rankedMusic: rankedMusic,
      rankedReal: rankedReal,
    );
    // loadChannel();
  }

  void loadChannel() async {
    final List<SubjectModel> tempAnime = [];
    final List<SubjectModel> tempBook = [];
    final List<SubjectModel> tempMusic = [];
    final List<SubjectModel> tempGame = [];
    final List<SubjectModel> tempReal = [];
    final Map<ScreenSubjectOption, ChannelModel> tempChannel = {};
    for (var element in ScreenSubjectOption.values) {
      final valid = [
        ScreenSubjectOption.anime,
        ScreenSubjectOption.book,
        ScreenSubjectOption.game,
        ScreenSubjectOption.music,
        ScreenSubjectOption.real,
      ].contains(element);
      if (!valid) continue;
      final channel = await BadRepository.fetchChannel(element);
      tempChannel.addAll({element: channel});
      if (channel.rank != null) {
        switch (element) {
          case ScreenSubjectOption.anime:
            for (var element in channel.rank!) {
              final subject =
                  await GlobalRepository.getSubject('${element.id}');
              tempAnime.add(subject.copyWith(follow: element.follow));
            }
            break;
          case ScreenSubjectOption.book:
            for (var element in channel.rank!) {
              final subject =
                  await GlobalRepository.getSubject('${element.id}');
              tempBook.add(subject.copyWith(follow: element.follow));
            }
            break;
          case ScreenSubjectOption.music:
            for (var element in channel.rank!) {
              final subject =
                  await GlobalRepository.getSubject('${element.id}');
              tempMusic.add(subject.copyWith(follow: element.follow));
            }
            break;
          case ScreenSubjectOption.game:
            for (var element in channel.rank!) {
              final subject =
                  await GlobalRepository.getSubject('${element.id}');
              tempGame.add(subject.copyWith(follow: element.follow));
            }
            break;
          case ScreenSubjectOption.real:
            for (var element in channel.rank!) {
              final subject =
                  await GlobalRepository.getSubject('${element.id}');
              tempReal.add(subject.copyWith(follow: element.follow));
            }
            break;
          default:
            break;
        }
      }
    }

    tempAnime.removeWhere((element) => element.id == null);
    tempBook.removeWhere((element) => element.id == null);
    tempGame.removeWhere((element) => element.id == null);
    tempMusic.removeWhere((element) => element.id == null);
    tempReal.removeWhere((element) => element.id == null);

    final sameAnime = state.rankedAnime == tempAnime;
    final sameBook = state.rankedBook == tempBook;
    final sameGame = state.rankedGame == tempGame;
    final sameMusic = state.rankedMusic == tempMusic;
    final sameReal = state.rankedReal == tempReal;

    if (sameAnime && sameBook && sameGame && sameMusic && sameReal) return;

    StorageHelper.write(
      option: StorageHelperOption.homeAnimeList,
      value: jsonEncode(
        {
          ScreenSubjectOption.anime.toJson():
              tempAnime.map((e) => e.toJson()).toList(),
          ScreenSubjectOption.book.toJson():
              tempBook.map((e) => e.toJson()).toList(),
          ScreenSubjectOption.game.toJson():
              tempGame.map((e) => e.toJson()).toList(),
          ScreenSubjectOption.music.toJson():
              tempMusic.map((e) => e.toJson()).toList(),
          ScreenSubjectOption.real.toJson():
              tempReal.map((e) => e.toJson()).toList(),
        },
      ),
    );

    state = state.copyWith(
      stateEnum: DiscoverViewStateEnum.success,
      channel: tempChannel,
      rankedAnime: tempAnime,
      rankedBook: tempBook,
      rankedGame: tempGame,
      rankedMusic: tempMusic,
      rankedReal: tempReal,
    );
  }
}

final discoverViewProvider =
    StateNotifierProvider<DiscoverViewStateNotifier, DiscoverViewState>((ref) {
  return DiscoverViewStateNotifier();
});
