// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alt_bangumi/constants/enum_constant.dart';
import 'package:alt_bangumi/repositories/bad_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/browser_rank_model.dart';

enum SingleTagScreenStateEnum { initial, loading, failure, success }

class SingleTagScreenState {
  final SingleTagScreenStateEnum stateEnum;
  final SortOption sortOption;
  final ScreenSubjectOption subjectOption;
  final int page;
  final int? year;
  final int? month;
  final List<BrowserRankModel>? results;

  SingleTagScreenState({
    required this.stateEnum,
    required this.sortOption,
    required this.subjectOption,
    required this.page,
    required this.year,
    required this.month,
    required this.results,
  });

  SingleTagScreenState copyWith({
    SingleTagScreenStateEnum? stateEnum,
    SortOption? sortOption,
    ScreenSubjectOption? subjectOption,
    int? page,
    required int? year,
    required int? month,
    required List<BrowserRankModel>? results,
  }) {
    return SingleTagScreenState(
      stateEnum: stateEnum ?? this.stateEnum,
      sortOption: sortOption ?? this.sortOption,
      subjectOption: subjectOption ?? this.subjectOption,
      page: page ?? this.page,
      year: year,
      month: month,
      results: results,
    );
  }
}

class SingleTagScreenNotifier extends StateNotifier<SingleTagScreenState> {
  SingleTagScreenNotifier()
      : super(
          SingleTagScreenState(
            stateEnum: SingleTagScreenStateEnum.initial,
            sortOption: SortOption.title,
            subjectOption: ScreenSubjectOption.anime,
            page: 1,
            year: null,
            month: null,
            results: null,
          ),
        );

  void search(String text) async {
    state = state.copyWith(
      stateEnum: SingleTagScreenStateEnum.loading,
      results: null,
      year: state.year,
      month: state.month,
    );
    try {
      final results = await BadRepository.fetchSubjectsByTag(
        subjectOption: state.subjectOption,
        sortOption: state.sortOption,
        text: text,
        page: state.page,
        year: state.year,
        month: state.month,
      );
      state = state.copyWith(
        stateEnum: SingleTagScreenStateEnum.success,
        results: results,
        year: state.year,
        month: state.month,
      );
    } catch (e) {
      state = state.copyWith(
        stateEnum: SingleTagScreenStateEnum.failure,
        results: state.results,
        year: state.year,
        month: state.month,
      );
    }
  }

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
}

final singleTagScreenProvider = AutoDisposeStateNotifierProvider<
    SingleTagScreenNotifier, SingleTagScreenState>(
  (ref) => SingleTagScreenNotifier(),
);
