// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/repositories/bad_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/browser_rank_model.dart';

enum RankingScreenStateEnum { initial, loading, sorting, failure, success }

class RankingScreenState {
  final RankingScreenStateEnum stateEnum;
  final SortOption sortOption;
  final ScreenSubjectOption subjectOption;
  final int page;
  final int? year;
  final int? month;
  final AnimeTypeOption? animeTypeOption;
  final BookTypeOption? bookTypeOption;
  final RealTypeOption? realTypeOption;
  final GameTypeOption? gameTypeOption;
  final List<BrowserRankModel>? results;

  RankingScreenState({
    required this.stateEnum,
    required this.sortOption,
    required this.subjectOption,
    required this.page,
    required this.year,
    required this.month,
    required this.animeTypeOption,
    required this.bookTypeOption,
    required this.realTypeOption,
    required this.gameTypeOption,
    required this.results,
  });

  RankingScreenState copyWith({
    RankingScreenStateEnum? stateEnum,
    SortOption? sortOption,
    ScreenSubjectOption? subjectOption,
    int? page,
    AnimeTypeOption? animeTypeOption,
    BookTypeOption? bookTypeOption,
    RealTypeOption? realTypeOption,
    GameTypeOption? gameTypeOption,
    required int? year,
    required int? month,
    required List<BrowserRankModel>? results,
  }) {
    return RankingScreenState(
      stateEnum: stateEnum ?? this.stateEnum,
      sortOption: sortOption ?? this.sortOption,
      subjectOption: subjectOption ?? this.subjectOption,
      page: page ?? this.page,
      year: year,
      month: month,
      animeTypeOption: animeTypeOption ?? this.animeTypeOption,
      bookTypeOption: bookTypeOption ?? this.bookTypeOption,
      realTypeOption: realTypeOption ?? this.realTypeOption,
      gameTypeOption: gameTypeOption ?? this.gameTypeOption,
      results: results,
    );
  }
}

class RankingScreenNotifier extends StateNotifier<RankingScreenState> {
  RankingScreenNotifier()
      : super(
          RankingScreenState(
            stateEnum: RankingScreenStateEnum.initial,
            sortOption: SortOption.rank,
            subjectOption: ScreenSubjectOption.anime,
            page: 1,
            year: null,
            month: null,
            animeTypeOption: null,
            bookTypeOption: null,
            realTypeOption: null,
            gameTypeOption: null,
            results: null,
          ),
        );

  void search() async {
    state = state.copyWith(
      stateEnum: RankingScreenStateEnum.loading,
      results: null,
      year: state.year,
      month: state.month,
    );
    try {
      final results = await BadRepository.fetchRank(
        subjectOption: state.subjectOption,
        sortOption: state.sortOption,
        year: state.year,
        month: state.month,
        animeTypeOption: state.animeTypeOption,
        bookTypeOption: state.bookTypeOption,
        realTypeOption: state.realTypeOption,
        gameTypeOption: state.gameTypeOption,
        page: state.page,
      );
      state = state.copyWith(
        stateEnum: RankingScreenStateEnum.success,
        results: results,
        year: state.year,
        month: state.month,
      );
    } catch (e) {
      state = state.copyWith(
        stateEnum: RankingScreenStateEnum.failure,
        results: state.results,
        year: state.year,
        month: state.month,
      );
    }
  }

  // void loading() async {
  //   try {
  //     final results = await BadRepository.fetchRank(
  //       subjectOption: state.subjectOption,
  //       sortOption: state.sortOption,
  //       year: state.year,
  //       month: state.month,
  //       animeTypeOption: state.animeTypeOption,
  //       bookTypeOption: state.bookTypeOption,
  //       realTypeOption: state.realTypeOption,
  //       gameTypeOption: state.gameTypeOption,
  //       page: state.page,
  //     );
  //     if (results == null) return;
  //     final oldResults = state.results?..addAll(results);
  //     state = state.copyWith(
  //       results: oldResults,
  //       year: state.year,
  //       month: state.month,
  //     );
  //   } finally {}
  // }

  void selectSubject(ScreenSubjectOption subjectOption) {
    state = state.copyWith(
      subjectOption: subjectOption,
      results: state.results,
      year: state.year,
      month: state.month,
      page: 1,
    );
  }

  void selectSort(SortOption sortOption) {
    state = state.copyWith(
      sortOption: sortOption,
      year: state.year,
      month: state.month,
      results: state.results,
      page: 1,
    );
  }

  void selectCategory(ScreenSubjectOption subjectOption) {
    state = state.copyWith(
      subjectOption: subjectOption,
      results: state.results,
      year: state.year,
      month: state.month,
      page: 1,
    );
  }

  void selectPage(int page) {
    state = state.copyWith(
      year: state.year,
      month: state.month,
      results: state.results,
      page: page,
    );
  }

  void selectYear(int? year) {
    state = state.copyWith(
      year: year,
      results: state.results,
      month: state.month,
      page: 1,
    );
  }

  void selectMonth(int? month) {
    state = state.copyWith(
      month: month,
      results: state.results,
      year: state.year,
      page: 1,
    );
  }

  void selectAnimeTypeOption(AnimeTypeOption animeTypeOption) {
    state = state.copyWith(
      animeTypeOption: animeTypeOption,
      results: state.results,
      year: state.year,
      month: state.month,
      page: 1,
    );
  }

  void selectBookTypeOption(BookTypeOption bookTypeOption) {
    state = state.copyWith(
      bookTypeOption: bookTypeOption,
      results: state.results,
      year: state.year,
      month: state.month,
      page: 1,
    );
  }

  void selectRealTypeOption(RealTypeOption realTypeOption) {
    state = state.copyWith(
      realTypeOption: realTypeOption,
      results: state.results,
      year: state.year,
      month: state.month,
      page: 1,
    );
  }

  void selectGameTypeOption(GameTypeOption gameTypeOption) {
    state = state.copyWith(
      gameTypeOption: gameTypeOption,
      results: state.results,
      year: state.year,
      month: state.month,
      page: 1,
    );
  }
}

final rankingScreenProvider =
    AutoDisposeStateNotifierProvider<RankingScreenNotifier, RankingScreenState>(
  (ref) => RankingScreenNotifier(),
);
