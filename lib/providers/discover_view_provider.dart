// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/models/subject_model/subject_model.dart';
import 'package:alt_bangumi/repositories/bad_repository.dart';
import 'package:alt_bangumi/repositories/global_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:alt_bangumi/models/channel_model/channel_model.dart';

enum DiscoverViewStateEnum { initial, loading, failure, success }

class DiscoverViewState {
  final DiscoverViewStateEnum stateEnum;
  final Map<SearchScreenSubjectOption, ChannelModel>? channel;
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
    Map<SearchScreenSubjectOption, ChannelModel>? channel,
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

  void loadChannel() async {
    state = state.copyWith(
      stateEnum: DiscoverViewStateEnum.loading,
    );
    final List<SubjectModel> tempAnime = [];
    final List<SubjectModel> tempBook = [];
    final List<SubjectModel> tempMusic = [];
    final List<SubjectModel> tempGame = [];
    final List<SubjectModel> tempReal = [];
    final Map<SearchScreenSubjectOption, ChannelModel> tempChannel = {};
    for (var element in SearchScreenSubjectOption.values) {
      final valid = [
        SearchScreenSubjectOption.anime,
        SearchScreenSubjectOption.book,
        SearchScreenSubjectOption.game,
        SearchScreenSubjectOption.music,
        SearchScreenSubjectOption.real,
      ].contains(element);
      if (!valid) continue;
      final channel = await BadRepository.fetchChannel(element);
      tempChannel.addAll({element: channel});
      if (channel.rank != null) {
        switch (element) {
          case SearchScreenSubjectOption.anime:
            for (var element in channel.rank!) {
              final subject =
                  await GlobalRepository.getSubject('${element.id}');
              tempAnime.add(subject);
            }
            break;
          case SearchScreenSubjectOption.book:
            for (var element in channel.rank!) {
              final subject =
                  await GlobalRepository.getSubject('${element.id}');
              tempBook.add(subject);
            }
            break;
          case SearchScreenSubjectOption.music:
            for (var element in channel.rank!) {
              final subject =
                  await GlobalRepository.getSubject('${element.id}');
              tempMusic.add(subject);
            }
            break;
          case SearchScreenSubjectOption.game:
            for (var element in channel.rank!) {
              final subject =
                  await GlobalRepository.getSubject('${element.id}');
              tempGame.add(subject);
            }
            break;
          case SearchScreenSubjectOption.real:
            for (var element in channel.rank!) {
              final subject =
                  await GlobalRepository.getSubject('${element.id}');
              tempReal.add(subject);
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
